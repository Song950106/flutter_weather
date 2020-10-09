import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../JsonBean/JsonBeans.dart';
import '../ToastUtil.dart';
import 'dart:math';
import 'dart:ui' as ui;
import '../GlobalValues/Variables.dart';

class MainPage extends StatefulWidget{

  State<StatefulWidget> createState() {
    return _MainPageState("郑州","刚刚更新");
  }
}

class _MainPageState extends State<MainPage>{

  String _city ;
  String _updateTime;
  WeeklyWeatherData weeklyWeatherData;
  NowWeatherData nowWeatherData;
  DailyWeatherData dailyWeatherData;
  List<TemperaturePair> temperatures;

  _MainPageState(this._city,this._updateTime);

  Future _getWeatherJson(String city) async {
    try{
      await platform.invokeMethod(GET_WEATHER_NOW,city);
      await platform.invokeMethod(GET_WEATHER_DAILY,city);
      await platform.invokeMethod(GET_WEATHER_WEEKLY,city);
    }on PlatformException catch (e){
      print("get invoke method error. ${e.message}");
    }
  }

  @override
  void initState(){
    super.initState();
    //eventChannel callBack register
    streamSubscription = eventChannelPlugin
        .receiveBroadcastStream("event channel established")
        .listen(_onToDart, onError: _onToDartError, onDone: _onDone);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    if(null != ModalRoute.of(context).settings.arguments && "" != ModalRoute.of(context).settings.arguments)
      _city = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: WeatherAppBar(context,city: _city, updateTime: _updateTime,),
      body: SafeArea(
        child: RefreshIndicator(
          // ignore: missing_return
          onRefresh: _loadData,
          child: ContentArea(),
        ),
      ),
    );
  }

  void _onToDart(message) {
    int flag = int.parse(message.toString()[0]);
    Map map = json.decode(message.toString().substring(1,message.toString().length));
    if ("200" != map["code"]){
      print("status code is wrong ${map["code"]}");
      return;
    }
    print("======= $map  =============");
    switch(flag){
      // weather now data
      case 0 :
        nowWeatherData = NowWeatherData.fromJson(map);
        // current temperature && current weather status
        weatherReportsKey.currentState.updateWeatherNow(int.parse(nowWeatherData.now.temp),
                                                        nowWeatherData.now.text);
        break;
      // weather daily data
      case 1:
        dailyWeatherData = DailyWeatherData.fromJson(map);
        break;
      // weather weekly data
      case 2:
        weeklyWeatherData = WeeklyWeatherData.fromJson(map);
        // maxTemp && minTemp today
        weatherReportsKey.currentState.updateWeatherReportState(int.parse(weeklyWeatherData.dailyData[0].tempMin),
                                                                int.parse(weeklyWeatherData.dailyData[0].tempMax));
        break;
    }
    print("======= ${dailyWeatherData.hourlyData[0].windDir}  =============");
  }

  //当native出错时，发送的数据
  void _onToDartError(error) {
    print(error);
  }
  //当native发送数据完成时调用的方法，每一次发送完成就会调用
  void _onDone() {
    print("消息传递完毕");
  }

  void _updateWeather(WeeklyWeatherData weeklyWeatherData){
    List<DailyData> daily_data = weeklyWeatherData.dailyData;
      for(DailyData data in daily_data){
        temperatures.add(TemperaturePair(int.parse(data.tempMax), int.parse(data.tempMin)));
      }
  }

  void updateWeeklyTemperature(List<TemperaturePair> temperaturePairs){
    setState(() {

    });
  }

  Future<void> _loadData() async{
    setState(() {
      isUpdating = true;
    });
    int result = await _getWeatherJson("");
    setState(() {isUpdating = false;});
    if(-1 == result ){
      Toast.show(context, "网络未连接");
    }
  }

  @override
  void dispose(){
    super.dispose();
    if (streamSubscription != null) {
      streamSubscription.cancel();
      streamSubscription = null;
    }
  }
}

class ContentArea extends StatefulWidget{

  List<TemperaturePair> temperatures;

  @override
  State<StatefulWidget> createState() {
    return ContentAreaState(temperatures:temperatures);
  }

}

class ContentAreaState extends State<ContentArea>{

  ContentAreaState({this.temperatures});
  List<TemperaturePair> temperatures;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 1.5,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blueAccent,Colors.lightBlueAccent],begin: Alignment.topCenter,end: Alignment.bottomCenter),
        ),
        child: ListView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2 - 100 ),
            children: <Widget>[
              WeatherReport(weatherReportsKey),
              Container(height: smallMargin),
              WeekPredictionRow(),
              Diagram(
                temperaturePairs: null == temperatures? List.generate(6,(i)=>TemperaturePair(10+pow(-1, i)*3,20+pow(-1, i)*2)) : temperatures,
                itemWidth: MediaQuery.of(context).size.width/6,
              ),
              Container(height: smallMargin),
              Divider(color: Colors.white70),
              Container(
                //                decoration: BoxDecoration(color: Colors.black),
                padding: EdgeInsets.only(top: smallMargin ,bottom: smallMargin),
                height: 100,
                child: TimeReportRow(),
              ),
              Divider(color: Colors.white70),
              Container(
                height: MediaQuery.of(context).size.height/3 - 80,
                child:OtherWetherParams(),
              ),
            ]
        )
    );
  }

}


class WeatherReport extends StatefulWidget{

  final Key key ;

  const WeatherReport(this.key);
//  final int currTemperature;
//  final int lowTemperature;
//  final int highTemperature;
//  final String weatherStatus;

  @override
  State<StatefulWidget> createState() {
    return WeatherReportState();
  }
}

class WeatherReportState extends State<WeatherReport>{
  WeatherReportState();
  int _currTemperature = 0;
  int _lowTemperature = 0;
  int _highTemperature = 0;
  String _weatherStatus = "";

  void updateWeatherReportState(lowTemperature, highTemperature){
    setState(() {
      _lowTemperature = lowTemperature;
      _highTemperature = highTemperature;
    });
  }

  void updateWeatherNow(currTemperature, weatherStatus){
    setState(() {
      _currTemperature = currTemperature;
      _weatherStatus = weatherStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new ListTile(
            title: new Text(_currTemperature.toString() + "℃",style: TextStyle(color: Colors.white,fontSize:32 ),),
            subtitle: new Text(_weatherStatus + " " + _lowTemperature.toString() + "/" + _highTemperature.toString(),style: smallFront)
        ),

      ],
    );
  }
}


class WeatherAppBar extends AppBar{

  WeatherAppBar(this.context,{this.city, this.updateTime,this.temperatures}):super();
  final String city;
  final String updateTime;
  List<TemperaturePair> temperatures;
  BuildContext context;

  @override
  Widget get title => Column(
    crossAxisAlignment:CrossAxisAlignment.start,
    children: <Widget>[
      Text(city,style:TextStyle(color:Colors.black,fontSize:26)),
      Text(updateTime,style:isUpdating?TextStyle(color:Colors.white70,fontSize:13) :TextStyle(color:Colors.grey,fontSize:13))
    ],
  );

  @override
  Widget get leading => Icon(Icons.place);

  @override
  List<Widget> get actions => [
    IconButton(icon: Icon(Icons.error) ,onPressed: () {  },tooltip: "预警",),
    IconButton(icon: Icon(Icons.location_city),onPressed: (){
      Navigator.of(context).pushNamed("cities");
    },tooltip: "城市列表",),
    PopupMenuButton(icon: Icon(Icons.more_vert),tooltip: "更多选项",
      itemBuilder: (BuildContext context)=>
      <PopupMenuItem<String>>[
        new PopupMenuItem<String>(
            value: 'share', child: new Text('分享')),
        new PopupMenuItem<String>(
            value: 'settings', child: new Text('设置')),
      ],
      onSelected: (String value){

      },
    )
  ];
}

class WeekPredictionRow extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WeekPredictionRowState();
  }
}

class WeekPredictionData{
  WeekPredictionData(offset);
  int weekday = 1;
  String date = "2020-10-09";
  String weatherStatus = "晴";
}
// TODO
class WeekPredictionRowState extends State<WeekPredictionRow>{
  List<WeekPredictionData> _weekPredictionData = List.generate(7, (index) => WeekPredictionData(index));
  void updateWeekPredictionRowState(){
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: <Widget>[
        Expanded( child: WeekPrediction(weekday: "今天",date: "6月1日",weatherStatus: "晴",)),
        Expanded( child:WeekPrediction(weekday: "星期一",date: "6月2日",weatherStatus: "多云")),
        Expanded( child:WeekPrediction(weekday: "星期二",date: "6月3日",weatherStatus: "晴")),
        Expanded( child:WeekPrediction(weekday: "星期三",date: "6月4日",weatherStatus: "晴")),
        Expanded( child:WeekPrediction(weekday: "星期四",date: "6月5日",weatherStatus: "晴")),
        Expanded( child:WeekPrediction(weekday: "星期五",date: "6月6日",weatherStatus: "阵雨")),
      ],
    );
  }

}

class WeekPrediction extends StatefulWidget{

  WeekPrediction({Key key, this.weekday, this.weatherIcon, this.date,this.weatherStatus}) : super(key: key);
  final String weekday;
  final Icon weatherIcon;
  final String date;
  final String weatherStatus;

  @override
  State<StatefulWidget> createState() {
    return _WeekPredictionState(weekday,weatherIcon,date,weatherStatus);
  }
}

class _WeekPredictionState extends State<WeekPrediction>{

  _WeekPredictionState(this.weekday, this.weatherIcon, this.date,this.weatherStatus);
  final String weekday;
  final Icon weatherIcon;
  final String date;
  final String weatherStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weekday,style: TextStyle(color: Colors.white,fontSize: 13)),
        Text(date,style: TextStyle(color: Colors.white,fontSize: 13)),
        Icon(Icons.wb_sunny,size: 24,color: Colors.white,),
        Text(weatherStatus,style: TextStyle(color: Colors.white,fontSize: 13)),
      ],
    );
  }
}

class TemperaturePair {
  int maxTem, minTem;
  TemperaturePair(this.maxTem, this.minTem);
}

class Diagram extends StatefulWidget{

  Diagram({Key key, this.temperaturePairs,this.itemWidth}) : super(key: key);
  List<TemperaturePair> temperaturePairs;
  final double itemWidth;
  @override
  State<StatefulWidget> createState() {
    return DiagramState(temperaturePairs,itemWidth);
  }
}

class DiagramState extends State<Diagram>{

  DiagramState(this.temperaturePairs,this.itemWidth);
  List<TemperaturePair> temperaturePairs;
  final double itemWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CustomPainter(context,temperaturePairs,itemWidth),
      size: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height/6 + 120),
    );
  }
}

class _CustomPainter extends CustomPainter{

  _CustomPainter(context,this.temperaturePairs,this.itemWidth); //最高/低温度
  BuildContext context;
  final List<TemperaturePair> temperaturePairs;
  final double itemWidth; //每个item的宽度
  final double textHeight = 80; //显示文字的高度
  final double temHeight = 40; //温度区域的高度
  TemperaturePair temperatureRecorder = TemperaturePair(0,0);

  void getMaxMinTem(){
    var _minTem = temperaturePairs[0].minTem;
    var _maxTem = temperaturePairs[0].maxTem;
    for(var pair in temperaturePairs){
      _minTem = min(_minTem, pair.minTem);
      _maxTem = max(_maxTem,pair.maxTem);
    }
    temperatureRecorder.maxTem = _maxTem;
    temperatureRecorder.minTem = _minTem;
  }

  @override
  void paint(Canvas canvas, Size size) {
    getMaxMinTem();
    double oneTemHeight = temHeight / (temperatureRecorder.maxTem - temperatureRecorder.minTem);
    Path maxPath = Path();
    Path minPath = Path();
    // 函数图表
    Paint _paint = Paint();
    _paint.color = Colors.white;
    _paint.style = PaintingStyle.stroke;
    _paint.isAntiAlias = true;
    _paint.strokeWidth = 3;
    // 气温 坐标点
    Paint _pointPaint = Paint();
    _pointPaint.strokeWidth =5;
    _pointPaint.color = Colors.redAccent;
    List<Offset> _maxPoints = [];
    List<Offset> _minPoints = [];

    for ( int i = 0; i < temperaturePairs.length; i++){
      double dx = itemWidth/2 + itemWidth * i;
      double maxDy = textHeight + (temperatureRecorder.maxTem - temperaturePairs[i].maxTem ) * oneTemHeight;
      double minDy = textHeight + (temperatureRecorder.maxTem - temperaturePairs[i].minTem ) * oneTemHeight;

      _maxPoints.add(Offset(dx,maxDy));
      _minPoints.add(Offset(dx,minDy));
      if(i == 0){
        maxPath.moveTo(dx, maxDy);
        minPath.moveTo(dx, minDy);
      }else {
        maxPath.lineTo(dx, maxDy);
        minPath.lineTo(dx, minDy);
      }
    }
    canvas.drawPath(maxPath, _paint);
    canvas.drawPath(minPath, _paint);
    canvas.drawPoints(ui.PointMode.points, _maxPoints, _pointPaint);
    canvas.drawPoints(ui.PointMode.points, _minPoints, _pointPaint);
    _drawText(canvas, _maxPoints, -1);
    _drawText(canvas, _minPoints, 1);

  }

  void _drawText(Canvas canvas,List<Offset> offsets,int flag,{double frontSize}){
    var pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,//居中
      fontSize: frontSize == null ?14:frontSize,//大小
    ));
    //文字颜色
    pb.pushStyle(ui.TextStyle(color: Colors.white));
    //绘制文字
    flag = flag~/flag.abs();
    for(int i = 0; i< offsets.length;i++){
      //添加文字
      if (1 == flag)
        pb.addText(temperaturePairs[i].maxTem.toString());
      else if(-1 == flag)
        pb.addText(temperaturePairs[i].minTem.toString());
      //文本宽度
      var paragraph = pb.build()..layout(ui.ParagraphConstraints(width: itemWidth/4));
      canvas.drawParagraph(paragraph, Offset(offsets[i].dx - 7,offsets[i].dy + 14*flag - 7));
    }
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TimeReportRow extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 24,
        itemBuilder: (context, i) => new Container(
            width: MediaQuery.of(context).size.width/6,
            child: TimeReport(currHour: _currentHour(i),temperature: (pow(-1, i)+12).toString()+"℃",)
        )
    );
  }
  String _currentHour(int offset){
    var now = DateTime.now().hour + offset;
    if ( now >= 24)
      now -= 24;
    return now.toString()+ " : 00";
  }
}

class TimeReport extends StatefulWidget{
  TimeReport({Key key, this.currHour,this.temperature}) : super(key: key);
  final String currHour;
  final String temperature;
  @override
  State<StatefulWidget> createState() {
    return TimeReportState(currHour,temperature);
  }
}

class TimeReportState extends State<TimeReport>{
  TimeReportState(this.currHour,this.temperature);
  final String currHour;
  //TODO final int weatherStatus;
  final String temperature;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(currHour,style: TextStyle(color: Colors.white70,fontSize: 13)),
        Icon(Icons.cloud,color: Colors.white,size: 24,),
        Text(temperature,style: TextStyle(color: Colors.white70,fontSize: 13)),
      ],
    );
  }
}

class OtherWetherParams extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return OtherWetherParamsState();
  }
}

class OtherWetherParamsState extends State<OtherWetherParams>{
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: paramsName.length,
      semanticChildCount: 2,
      padding: EdgeInsets.only(left: smallMargin),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //横轴元素个数
          crossAxisCount: 2,
          //纵轴间距
          mainAxisSpacing:0,
          //横轴间距
          crossAxisSpacing: 0,
          //子组件宽高长度比例
          childAspectRatio: 4.0
      ),
      itemBuilder: (context,index)=> new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(paramsName[index],style: TextStyle(color: Colors.white70,fontSize: 13),),
          Text(paramsValue[index],style: TextStyle(color: Colors.white,fontSize: 13)),
        ],
      ),
      //禁滑
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}