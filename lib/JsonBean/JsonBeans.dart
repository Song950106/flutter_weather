import 'package:json_annotation/json_annotation.dart';

part 'JsonBeans.g.dart';


// a week weather status prediction
@JsonSerializable()
class WeeklyWeatherData{
  @JsonKey(name:"code")
  String code ;
  @JsonKey(name:"updateTime")
  String updateTime;
  @JsonKey(name:"fxLink")
  String fxLink;
  @JsonKey(name:"daily")
  List<DailyData> dailyData;
  @JsonKey(name:"refer")
  ReferInfo refer;

  WeeklyWeatherData(this.code, this.updateTime, this.fxLink, this.dailyData);
  //反序列化
  factory WeeklyWeatherData.fromJson(Map<String, dynamic> json) => _$WeeklyWeatherDataFromJson(json);
//序列化
  Map<String, dynamic> toJson() => _$WeeklyWeatherDataToJson(this);
}

@JsonSerializable()
class DailyData{
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

  DailyData(
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
  factory DailyData.fromJson(Map<String,dynamic> json) => _$DailyDataFromJson(json);
}


@JsonSerializable()
class DailyWeatherData{
  @JsonKey(name:"code")
  String code;
  @JsonKey(name:"updateTime")
  String updateTime;
  @JsonKey(name:"fxLink")
  String fxLink;
  @JsonKey(name:"hourly")
  List<HourlyData> hourlyData;
  @JsonKey(name:"refer")
  ReferInfo refer;

  DailyWeatherData(this.code, this.updateTime, this.fxLink, this.hourlyData,
      this.refer);

  factory DailyWeatherData.fromJson(Map<String,dynamic> json) => _$DailyWeatherDataFromJson(json);
}

@JsonSerializable()
class HourlyData{
  @JsonKey(name:"fxTime")
  String fxTime;
  @JsonKey(name:"temp")
  String temp;
  @JsonKey(name:"icon")
  String icon;
  @JsonKey(name:"text")
  String text;
  @JsonKey(name:"wind360")
  String wind360;
  @JsonKey(name:"windDir")
  String windDir;
  @JsonKey(name:"windScale")
  String windScale;
  @JsonKey(name:"windSpeed")
  String windSpeed;
  @JsonKey(name:"humidity")
  String humidity;
  @JsonKey(name:"pop")
  String pop;
  @JsonKey(name:"precip")
  String precip;
  @JsonKey(name:"pressure")
  String pressure;
  @JsonKey(name:"cloud")
  String cloud;
  @JsonKey(name:"dew")
  String dew;

  HourlyData(this.fxTime, this.temp, this.icon, this.text, this.wind360,
      this.windDir, this.windScale, this.windSpeed, this.humidity, this.pop,
      this.precip, this.pressure, this.cloud, this.dew);

  factory HourlyData.fromJson(Map<String,dynamic> json) => _$HourlyDataFromJson(json);
}

@JsonSerializable()
class ReferInfo{
  @JsonKey(name:"source")
  List<String> sources;
  @JsonKey(name:"license")
  List<String> licenses;

  ReferInfo(this.sources, this.licenses);

  factory ReferInfo.fromJson(Map<String,dynamic> json) => _$ReferInfoFromJson(json);
}

@JsonSerializable()
class NowWeatherData{
  @JsonKey(name:"code")
  String code;
  @JsonKey(name:"updateTime")
  String updateTime;
  @JsonKey(name:"fxLink")
  String fxLink;
  @JsonKey(name:"now")
  NowData now;
  @JsonKey(name:"refer")
  ReferInfo refer;

  NowWeatherData(this.code, this.updateTime, this.fxLink, this.now, this.refer);

  factory NowWeatherData.fromJson(Map<String,dynamic> json) => _$NowWeatherDataFromJson(json);
}

@JsonSerializable()
class NowData{
  @JsonKey(name:"obsTime")
  String obsTime;
  @JsonKey(name:"temp")
  String temp;
  @JsonKey(name:"feelsLike")
  String feelsLike;
  @JsonKey(name:"icon")
  String icon;
  @JsonKey(name:"text")
  String text;
  @JsonKey(name:"wind360")
  String wind360;
  @JsonKey(name:"windDir")
  String windDir;
  @JsonKey(name:"windScale")
  String windScale;
  @JsonKey(name:"windSpeed")
  String windSpeed;
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
  @JsonKey(name:"dew")
  String dew;

  NowData(
      this.obsTime,
      this.temp,
      this.feelsLike,
      this.icon,
      this.text,
      this.wind360,
      this.windDir,
      this.windScale,
      this.windSpeed,
      this.humidity,
      this.precip,
      this.pressure,
      this.vis,
      this.cloud,
      this.dew);

  factory NowData.fromJson(Map<String,dynamic> json) => _$NowDataFromJson(json);
}


