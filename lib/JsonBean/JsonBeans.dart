import 'package:json_annotation/json_annotation.dart';

part 'JsonBeans.g.dart';

@JsonSerializable()
class WeeklyWeatherData{
  @JsonKey(name:"code")
  String code ;
  @JsonKey(name:"updateTime")
  String updateTime;
  @JsonKey(name:"fxLink")
  String fxLink;
  @JsonKey(name:"daily")
  List<DailyWeatherData> dailyData;

  WeeklyWeatherData(this.code, this.updateTime, this.fxLink, this.dailyData);
  //反序列化
  factory WeeklyWeatherData.fromJson(Map<String, dynamic> json) => _$WeeklyWeatherDataFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$WeeklyWeatherDataToJson(this);
}

@JsonSerializable()
class DailyWeatherData{
  @JsonKey(name:"fxDate")
  String fxDate ;
  @JsonKey(name:"sunrise")
  String sunrise;
  @JsonKey(name:"sunset")
  String sunset;
  @JsonKey(name:"moonrise")
  String moonrise;
  @JsonKey(name:"moonset")
  String moonset;
  @JsonKey(name:"moonPhase")
  String moonPhase;
  @JsonKey(name:"tempMax")
  String tempMax;
  @JsonKey(name:"tempMin")
  String tempMin;
  @JsonKey(name:"iconDay")
  String iconDay;
  @JsonKey(name:"textDay")
  String textDay;
  @JsonKey(name:"iconNight")
  String iconNight;
  @JsonKey(name:"textNight")
  String textNight;
  @JsonKey(name:"wind360Day")
  String wind360Day;
  @JsonKey(name:"windDirDay")
  String windDirDay;
  @JsonKey(name:"windScaleDay")
  String windScaleDay;
  @JsonKey(name:"windSpeedDay")
  String windSpeedDay;
  @JsonKey(name:"wind360Night")
  String wind360Night;
  @JsonKey(name:"windDirNight")
  String windDirNight;
  @JsonKey(name:"windScaleNight")
  String windScaleNight;
  @JsonKey(name:"windSpeedNight")
  String windSpeedNight;
  @JsonKey(name:"humidity")
  String humidity;
  @JsonKey(name:"precip")
  String precip;
  @JsonKey(name:"pressure")
  String pressure;
  @JsonKey(name:"vis")
  String vis;
  @JsonKey(name:"cloud")
  String cloud;
  @JsonKey(name:"uvIndex")
  String uvIndex;

  DailyWeatherData(
      this.fxDate,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.moonPhase,
      this.tempMax,
      this.tempMin,
      this.iconDay,
      this.textDay,
      this.iconNight,
      this.textNight,
      this.wind360Day,
      this.windDirDay,
      this.windScaleDay,
      this.windSpeedDay,
      this.wind360Night,
      this.windDirNight,
      this.windScaleNight,
      this.windSpeedNight,
      this.humidity,
      this.precip,
      this.pressure,
      this.vis,
      this.cloud,
      this.uvIndex);
  factory DailyWeatherData.fromJson(Map<String,dynamic> json) => _$DailyWeatherDataFromJson(json);
}