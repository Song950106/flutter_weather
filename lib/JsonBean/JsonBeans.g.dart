// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'JsonBeans.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyWeatherData _$WeeklyWeatherDataFromJson(Map<String, dynamic> json) {
  return WeeklyWeatherData(
      json['code'] as String,
      json['updateTime'] as String,
      json['fxLink'] as String,
      (json['daily'] as List)
          ?.map((e) =>
              e == null ? null : DailyData.fromJson(e as Map<String, dynamic>))
          ?.toList())
    ..refer = json['refer'] == null
        ? null
        : ReferInfo.fromJson(json['refer'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WeeklyWeatherDataToJson(WeeklyWeatherData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'updateTime': instance.updateTime,
      'fxLink': instance.fxLink,
      'daily': instance.dailyData,
      'refer': instance.refer
    };

DailyData _$DailyDataFromJson(Map<String, dynamic> json) {
  return DailyData(
      json['fxDate'] as String,
      json['sunrise'] as String,
      json['sunset'] as String,
      json['moonrise'] as String,
      json['moonset'] as String,
      json['moonPhase'] as String,
      json['tempMax'] as String,
      json['tempMin'] as String,
      json['iconDay'] as String,
      json['textDay'] as String,
      json['iconNight'] as String,
      json['textNight'] as String,
      json['wind360Day'] as String,
      json['windDirDay'] as String,
      json['windScaleDay'] as String,
      json['windSpeedDay'] as String,
      json['wind360Night'] as String,
      json['windDirNight'] as String,
      json['windScaleNight'] as String,
      json['windSpeedNight'] as String,
      json['humidity'] as String,
      json['precip'] as String,
      json['pressure'] as String,
      json['vis'] as String,
      json['cloud'] as String,
      json['uvIndex'] as String);
}

Map<String, dynamic> _$DailyDataToJson(DailyData instance) => <String, dynamic>{
      'fxDate': instance.fxDate,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'moonrise': instance.moonrise,
      'moonset': instance.moonset,
      'moonPhase': instance.moonPhase,
      'tempMax': instance.tempMax,
      'tempMin': instance.tempMin,
      'iconDay': instance.iconDay,
      'textDay': instance.textDay,
      'iconNight': instance.iconNight,
      'textNight': instance.textNight,
      'wind360Day': instance.wind360Day,
      'windDirDay': instance.windDirDay,
      'windScaleDay': instance.windScaleDay,
      'windSpeedDay': instance.windSpeedDay,
      'wind360Night': instance.wind360Night,
      'windDirNight': instance.windDirNight,
      'windScaleNight': instance.windScaleNight,
      'windSpeedNight': instance.windSpeedNight,
      'humidity': instance.humidity,
      'precip': instance.precip,
      'pressure': instance.pressure,
      'vis': instance.vis,
      'cloud': instance.cloud,
      'uvIndex': instance.uvIndex
    };

DailyWeatherData _$DailyWeatherDataFromJson(Map<String, dynamic> json) {
  return DailyWeatherData(
      json['code'] as String,
      json['updateTime'] as String,
      json['fxLink'] as String,
      (json['hourly'] as List)
          ?.map((e) =>
              e == null ? null : HourlyData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['refer'] == null
          ? null
          : ReferInfo.fromJson(json['refer'] as Map<String, dynamic>));
}

Map<String, dynamic> _$DailyWeatherDataToJson(DailyWeatherData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'updateTime': instance.updateTime,
      'fxLink': instance.fxLink,
      'hourly': instance.hourlyData,
      'refer': instance.refer
    };

HourlyData _$HourlyDataFromJson(Map<String, dynamic> json) {
  return HourlyData(
      json['fxTime'] as String,
      json['temp'] as String,
      json['icon'] as String,
      json['text'] as String,
      json['wind360'] as String,
      json['windDir'] as String,
      json['windScale'] as String,
      json['windSpeed'] as String,
      json['humidity'] as String,
      json['pop'] as String,
      json['precip'] as String,
      json['pressure'] as String,
      json['cloud'] as String,
      json['dew'] as String);
}

Map<String, dynamic> _$HourlyDataToJson(HourlyData instance) =>
    <String, dynamic>{
      'fxTime': instance.fxTime,
      'temp': instance.temp,
      'icon': instance.icon,
      'text': instance.text,
      'wind360': instance.wind360,
      'windDir': instance.windDir,
      'windScale': instance.windScale,
      'windSpeed': instance.windSpeed,
      'humidity': instance.humidity,
      'pop': instance.pop,
      'precip': instance.precip,
      'pressure': instance.pressure,
      'cloud': instance.cloud,
      'dew': instance.dew
    };

ReferInfo _$ReferInfoFromJson(Map<String, dynamic> json) {
  return ReferInfo((json['source'] as List)?.map((e) => e as String)?.toList(),
      (json['license'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$ReferInfoToJson(ReferInfo instance) =>
    <String, dynamic>{'source': instance.sources, 'license': instance.licenses};

NowWeatherData _$NowWeatherDataFromJson(Map<String, dynamic> json) {
  return NowWeatherData(
      json['code'] as String,
      json['updateTime'] as String,
      json['fxLink'] as String,
      json['now'] == null
          ? null
          : NowData.fromJson(json['now'] as Map<String, dynamic>),
      json['refer'] == null
          ? null
          : ReferInfo.fromJson(json['refer'] as Map<String, dynamic>));
}

Map<String, dynamic> _$NowWeatherDataToJson(NowWeatherData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'updateTime': instance.updateTime,
      'fxLink': instance.fxLink,
      'now': instance.now,
      'refer': instance.refer
    };

NowData _$NowDataFromJson(Map<String, dynamic> json) {
  return NowData(
      json['obsTime'] as String,
      json['temp'] as String,
      json['feelsLike'] as String,
      json['icon'] as String,
      json['text'] as String,
      json['wind360'] as String,
      json['windDir'] as String,
      json['windScale'] as String,
      json['windSpeed'] as String,
      json['humidity'] as String,
      json['precip'] as String,
      json['pressure'] as String,
      json['vis'] as String,
      json['cloud'] as String,
      json['dew'] as String);
}

Map<String, dynamic> _$NowDataToJson(NowData instance) => <String, dynamic>{
      'obsTime': instance.obsTime,
      'temp': instance.temp,
      'feelsLike': instance.feelsLike,
      'icon': instance.icon,
      'text': instance.text,
      'wind360': instance.wind360,
      'windDir': instance.windDir,
      'windScale': instance.windScale,
      'windSpeed': instance.windSpeed,
      'humidity': instance.humidity,
      'precip': instance.precip,
      'pressure': instance.pressure,
      'vis': instance.vis,
      'cloud': instance.cloud,
      'dew': instance.dew
    };
