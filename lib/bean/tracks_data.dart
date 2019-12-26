import 'package:json_annotation/json_annotation.dart';

part 'tracks_data.g.dart';


List<tracksData> gettracksDataList(List<dynamic> list){
  List<tracksData> result = [];
  list.forEach((item){
    result.add(tracksData.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class tracksData extends Object {

  @JsonKey(name: 'macId')
  String macId;

  @JsonKey(name: 'macType')
  String macType;

  @JsonKey(name: 'macName')
  String macName;

  @JsonKey(name: 'ico')
  int ico;

  @JsonKey(name: 'battery')
  int battery;

  @JsonKey(name: 'x')
  double x;

  @JsonKey(name: 'y')
  double y;

  @JsonKey(name: 'gpsTime')
  int gpsTime;

  @JsonKey(name: 'gsmTime')
  int gsmTime;

  @JsonKey(name: 'bvalid')
  int bvalid;

  @JsonKey(name: 'speed')
  String speed;

  @JsonKey(name: 'dir')
  String dir;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'door')
  int door;

  @JsonKey(name: 'online')
  int online;

  @JsonKey(name: 'activate')
  int activate;

  @JsonKey(name: 'sim')
  String sim;

  @JsonKey(name: 'acc')
  String acc;

  tracksData(this.macId,this.macType,this.macName,this.ico,this.battery,this.x,this.y,this.gpsTime,this.gsmTime,this.bvalid,this.speed,this.dir,this.status,this.door,this.online,this.activate,this.sim,this.acc,);

  factory tracksData.fromJson(Map<String, dynamic> srcJson) => _$tracksDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$tracksDataToJson(this);

}


