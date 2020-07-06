import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

final smallFront = TextStyle(color: Colors.white,fontSize:16);
final double commonMargin = 60.0;
final double smallMargin = 20.0;
// index 2 should be variable
List<String> paramsName = ["空气质量","PM2.5","东南风","体感温度","湿度","能见度","紫外线","气压"];
List<String> paramsValue = ["良","28","7.2km/h","28℃","58%","19.9km","最弱","991hPa"];
const platform = const MethodChannel('com.example.weather.weatherData');

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather test',
      initialRoute: '/',
      routes: {

        // When navigating to the "/second" route, build the SecondScreen widget.
        // 当我们跳转到“/second”时，构建 SecondScreen Widget（When we navigate to the "/second" route, build the SecondScreen Widget）
//        '/second': (context) => SecondScreen(),
      },
      debugShowCheckedModeBanner: false,
      color: Colors.lightBlueAccent,
      theme: ThemeData(
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget{
  @override
  // ignore: missing_return
  State<StatefulWidget> createState() {
      return _MainPageState("郑州","刚刚更新");
  }
}

class _MainPageState extends State<MainPage>{

  _MainPageState(this._city,this._updateTime);
    final String _city ;
    String _updateTime;

Future<void> _getWeatherJson(String city) async {
  try{
    String result  = await platform.invokeMethod('getWeatherData');
    setState(() {
      _updateTime  = result;
    });
  }on PlatformException catch (e){
    print("get invoke method error. ${e.message}");
  }
}

  @override
  Widget build(BuildContext context) {
    _getWeatherJson(_city);
    return Scaffold(
      appBar: WeatherAppBar(city: _city, updateTime: _updateTime),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.5,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blueAccent,Colors.lightBlueAccent],begin: Alignment.topCenter,end: Alignment.bottomCenter),
          ),
          child: ListView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2 - 100 ),
            children: <Widget>[
              WeatherReport(currTemperature: 25,lowTemperature: 20,highTemperature: 29,weatherStatus: "多云",),
              Container(height: smallMargin),
              WeekPredictionRow(),
              Diagram(
                temperaturePairs: List.generate(6,(i)=>TemperaturePair(10+pow(-1, i)*3,20+pow(-1, i)*2)),
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
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherReport extends StatefulWidget{

  const WeatherReport({Key key, this.currTemperature, this.lowTemperature, this.highTemperature, this.weatherStatus}) : super(key: key);
    final int currTemperature;
    final int lowTemperature;
    final int highTemperature;
    final String weatherStatus;

  @override
  State<StatefulWidget> createState() {
    return _WeatherReportState(currTemperature,lowTemperature,highTemperature,weatherStatus);
  }
}

class _WeatherReportState extends State<WeatherReport>{

  _WeatherReportState(this._currTemperature, this._lowTemperature, this._highTemperature, this._weatherStatus);
    final int _currTemperature;
    final int _lowTemperature;
    final int _highTemperature;
    final String _weatherStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(_currTemperature.toString() + "℃",style: TextStyle(color: Colors.white,fontSize:32 ),),
          subtitle: Text(_weatherStatus + " " + _lowTemperature.toString() + "/" + _highTemperature.toString(),style: smallFront)
      ),

      ],
    );
  }
}


class WeatherAppBar extends AppBar{

  WeatherAppBar({this.city, this.updateTime}):super();
    final String city;
    final String updateTime;

  @override
  Widget get title => Column(
    crossAxisAlignment:CrossAxisAlignment.start,
    children: <Widget>[
      Text(city,style:TextStyle(color:Colors.black,fontSize:26)),
      Text(updateTime,style:TextStyle(color:Colors.grey,fontSize:13))
    ],
  );

  @override
  Widget get leading => Icon(Icons.place);

  @override
  List<Widget> get actions => [
    IconButton(icon: Icon(Icons.error) ,onPressed: () {  },tooltip: "预警",),
    IconButton(icon: Icon(Icons.location_city),onPressed: (){},tooltip: "城市列表",),
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

class WeekPredictionRow extends StatelessWidget{
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
    final List<TemperaturePair> temperaturePairs;
    final double itemWidth;
  @override
  State<StatefulWidget> createState() {
    return DiagramState(temperaturePairs,itemWidth);
  }
}

class DiagramState extends State<Diagram>{

  DiagramState(this.temperaturePairs,this.itemWidth);
    final List<TemperaturePair> temperaturePairs;
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

