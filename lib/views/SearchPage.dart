import 'package:flutter/material.dart';
import '../GlobalValues/Variables.dart';

class SearchCity extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SearchState();
  }
}

class SearchState extends State<SearchCity>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: BackButton(onPressed: (){Navigator.pop(context);},),
              title: TextField(
                  autofocus: true,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                      hintText: "城市名",
                      border: InputBorder.none
                  )
              ),
            ),
            Divider(color: Colors.grey),
            Container(
              alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(20, 6, 20, 6),
                child: Text("热门城市",style: TextStyle(color: Colors.blue)),
              ),
            Wrap(
              spacing: 20.0, // 主轴(水平)方向间距
              runSpacing: 6.0, // 纵轴（垂直）方向间距
              alignment: WrapAlignment.start,
              children: hotCities.map((e) => ActionChip(
                label: Text(e),labelPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                onPressed: (){Navigator.pushNamedAndRemoveUntil(context, "mainPage", (route) => false,arguments: e);}
              )
              ).toList(),
            ),
          ],
        ),
      )
    );
  }
}
