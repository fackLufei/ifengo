import 'package:json_annotation/json_annotation.dart';

part 'alarms_data.g.dart';


@JsonSerializable()
class AlarmsData extends Object {

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  List<Alarm> data;

  @JsonKey(name: 'pageTotal')
  int pageTotal;

  AlarmsData(this.code,this.msg,this.data,this.pageTotal,);

  factory AlarmsData.fromJson(Map<String, dynamic> srcJson) => _$AlarmsDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlarmsDataToJson(this);

}


@JsonSerializable()
class Alarm extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'macId')
  String macId;

  @JsonKey(name: 'macName')
  String macName;

  @JsonKey(name: 'alarmType')
  int alarmType;

  @JsonKey(name: 'alarmDate')
  int alarmDate;

  @JsonKey(name: 'insDate')
  int insDate;

  @JsonKey(name: 'x')
  double x;

  @JsonKey(name: 'y')
  double y;

  @JsonKey(name: 'speed')
  int speed;

  @JsonKey(name: 'battery')
  int battery;

  @JsonKey(name: 'fenceName')
  String fenceName;

  @JsonKey(name: 'fenceRadius')
  int fenceRadius;

  @JsonKey(name: 'fenceX')
  double fenceX;

  @JsonKey(name: 'fenceY')
  double fenceY;

  @JsonKey(name: 'fenceNum')
  int fenceNum;

  Alarm(this.id,this.macId,this.macName,this.alarmType,this.alarmDate,this.insDate,this.x,this.y,this.speed,this.battery,this.fenceName,this.fenceRadius,this.fenceX,this.fenceY,this.fenceNum,);

  factory Alarm.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}


