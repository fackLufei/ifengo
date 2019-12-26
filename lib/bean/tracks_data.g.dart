// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracks_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

tracksData _$tracksDataFromJson(Map<String, dynamic> json) {
  return tracksData(
      json['macId'] as String,
      json['macType'] as String,
      json['macName'] as String,
      json['ico'] as int,
      json['battery'] as int,
      (json['x'] as num)?.toDouble(),
      (json['y'] as num)?.toDouble(),
      json['gpsTime'] as int,
      json['gsmTime'] as int,
      json['bvalid'] as int,
      json['speed'] as String,
      json['dir'] as String,
      json['status'] as int,
      json['door'] as int,
      json['online'] as int,
      json['activate'] as int,
      json['sim'] as String,
      json['acc'] as String);
}

Map<String, dynamic> _$tracksDataToJson(tracksData instance) =>
    <String, dynamic>{
      'macId': instance.macId,
      'macType': instance.macType,
      'macName': instance.macName,
      'ico': instance.ico,
      'battery': instance.battery,
      'x': instance.x,
      'y': instance.y,
      'gpsTime': instance.gpsTime,
      'gsmTime': instance.gsmTime,
      'bvalid': instance.bvalid,
      'speed': instance.speed,
      'dir': instance.dir,
      'status': instance.status,
      'door': instance.door,
      'online': instance.online,
      'activate': instance.activate,
      'sim': instance.sim,
      'acc': instance.acc
    };
