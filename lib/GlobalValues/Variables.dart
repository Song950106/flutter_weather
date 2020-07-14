import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final smallFront = TextStyle(color: Colors.white,fontSize:16);
final double commonMargin = 60.0;
final double smallMargin = 20.0;
bool isUpdating = false;
// index 2 should be variable
List<String> paramsName = ["空气质量","PM2.5","东南风","体感温度","湿度","能见度","紫外线","气压"];
List<String> paramsValue = ["良","28","7.2km/h","28℃","58%","19.9km","最弱","991hPa"];
const platform = const MethodChannel('com.example.weather.methodChannel');
const EventChannel eventChannelPlugin = EventChannel("com.example.weather.eventChannel");
StreamSubscription streamSubscription;