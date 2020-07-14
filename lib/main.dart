import 'dart:async';
import 'dart:convert';
import 'package:weather_flutter/views/CItyPage.dart';

import 'GlobalValues/Variables.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'views/MainPage.dart';



void main(){
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{

  @override
  void initState(){
    super.initState();
    FlutterBoost.singleton.registerPageBuilders(
      {
        "mainPage" : (pageName, params, _) => MainPage(),
        "cities" : (pageName, params, _) => Cities(),
      }
    );

    FlutterBoost.singleton.registerDefaultPageBuilder((pageName, params, uniqueId) => MainPage());
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather test',
      debugShowCheckedModeBanner: false,
      color: Colors.lightBlueAccent,
      theme: ThemeData(
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      builder: FlutterBoost.init(),
      home: Container(),
//    home: MainPage(),
    );
  }


  void _onRoutePushed(
      String pageName, String uniqueId, Map params, Route route, Future _) {
    debugPrint("pageName :$pageName" + "params :${params.toString()}");
  }

}



