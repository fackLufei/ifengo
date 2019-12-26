// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return UserData(
      json['userInfo'] == null
          ? null
          : UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      json['type'] as String,
      json['token'] as String);
}

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'userInfo': instance.userInfo,
      'type': instance.type,
      'token': instance.token
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
      json['id'] as int,
      json['headPicPath'] as String,
      json['nickName'] as String,
      json['language'] as String,
      json['phone'] as String,
      json['status'] as int,
      json['iconId'] as int);
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'headPicPath': instance.headPicPath,
      'nickName': instance.nickName,
      'language': instance.language,
      'phone': instance.phone,
      'status': instance.status,
      'iconId': instance.iconId
    };
