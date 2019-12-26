import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';


@JsonSerializable()
class UserData extends Object {

  @JsonKey(name: 'userInfo')
  UserInfo userInfo;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'token')
  String token;

  UserData(this.userInfo,this.type,this.token,);

  factory UserData.fromJson(Map<String, dynamic> srcJson) => _$UserDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

}


@JsonSerializable()
class UserInfo extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'headPicPath')
  String headPicPath;

  @JsonKey(name: 'nickName')
  String nickName;

  @JsonKey(name: 'language')
  String language;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'iconId')
  int iconId;

  UserInfo(this.id,this.headPicPath,this.nickName,this.language,this.phone,this.status,this.iconId,);

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) => _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

}


