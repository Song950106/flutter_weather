import 'package:flutter/material.dart';
import 'package:weather_flutter/views/SearchPage.dart';


class Cities extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CitiesState();
  }
}

class CitiesState extends State<Cities>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black,onPressed: (){
          Navigator.pop(context);
        },),
        title: Text("选择城市",style: TextStyle(color:Colors.black,fontSize:26),)
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, i) =>new Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              elevation: 20,
              color: Colors.blue,
              child: Container(
                height: MediaQuery.of(context).size.height/6,
              ),
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        tooltip: '添加城市',
        child: Icon(Icons.add),
        onPressed: (){
//          Navigator.of(context).push(MaterialPageRoute(builder: (context){return SearchCity();}));
          Navigator.of(context).pushNamed("search");
        },
      ),
    );
  }

}