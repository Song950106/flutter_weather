import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_flutter/views/MainPage.dart';

final smallFront = TextStyle(color: Colors.white,fontSize:16);
final double commonMargin = 60.0;
final double smallMargin = 20.0;
bool isUpdating = false;
// index 2 should be variable
List<String> paramsName = ["空气质量","PM2.5","东南风","体感温度","湿度","能见度","紫外线","气压"];
List<String> paramsValue = ["良","28","7.2km/h","28℃","58%","19.9km","最弱","991hPa"];
List<String> hotCities = ["北京","上海","深圳","广州","长春","长沙","成都",
                          "重庆","福州","贵阳","杭州","哈尔滨","合肥",
                          "济南","昆明","兰州","南昌","南京","南宁","沈阳"];

const platform = const MethodChannel('com.example.weather.methodChannel');
const EventChannel eventChannelPlugin = EventChannel("com.example.weather.eventChannel");

const String GET_WEATHER_DAILY = "getWeatherDaily";
const String GET_WEATHER_WEEKLY = "getWeatherWeekly";
const String GET_WEATHER_NOW = "getWeatherNow";
StreamSubscription streamSubscription;


GlobalKey<WeatherReportState> weatherReportsKey = GlobalKey();

