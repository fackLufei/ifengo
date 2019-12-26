// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarms_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmsData _$AlarmsDataFromJson(Map<String, dynamic> json) {
  return AlarmsData(
      json['code'] as int,
      json['msg'] as String,
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Alarm.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['pageTotal'] as int);
}

Map<String, dynamic> _$AlarmsDataToJson(AlarmsData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'pageTotal': instance.pageTotal
    };

Alarm _$DataFromJson(Map<String, dynamic> json) {
  return Alarm(
      json['id'] as int,
      json['macId'] as String,
      json['macName'] as String,
      json['alarmType'] as int,
      json['alarmDate'] as int,
      json['insDate'] as int,
      (json['x'] as num)?.toDouble(),
      (json['y'] as num)?.toDouble(),
      json['speed'] as int,
      json['battery'] as int,
      json['fenceName'] as String,
      json['fenceRadius'] as int,
      (json['fenceX'] as num)?.toDouble(),
      (json['fenceY'] as num)?.toDouble(),
      json['fenceNum'] as int);
}

Map<String, dynamic> _$DataToJson(Alarm instance) => <String, dynamic>{
      'id': instance.id,
      'macId': instance.macId,
      'macName': instance.macName,
      'alarmType': instance.alarmType,
      'alarmDate': instance.alarmDate,
      'insDate': instance.insDate,
      'x': instance.x,
      'y': instance.y,
      'speed': instance.speed,
      'battery': instance.battery,
      'fenceName': instance.fenceName,
      'fenceRadius': instance.fenceRadius,
      'fenceX': instance.fenceX,
      'fenceY': instance.fenceY,
      'fenceNum': instance.fenceNum
    };
