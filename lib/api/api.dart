import 'dart:io';

import 'package:dio/dio.dart';

import 'request.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:ifengo/utils/auth.dart';

class Api {
//  static const String DO_LOGIN = '/alarm/get-alarms';//获取报警详情
//
//  static const String DO_LOGIN = '/alarm/get-condition';//报警类型明细
//
//  static const String DO_LOGIN = '/track/get-tracks';//获取设备类别
//
//  static const String DO_LOGIN = '/user/dev-bind';//绑定设备
//
//  static const String DO_LOGIN = '/dev/get-dev';//获取设备详情
//
//  static const String DO_LOGIN = '/user/dev-relieve';//解除绑定
//
//  static const String DO_LOGIN = '/fence/get-fences';//围栏列表
//
//  static const String DO_LOGIN = '/record/get-record-info';//音频列表
//
//  static const String DO_LOGIN = '/user/modify-user';//修改用户  信息
//  static const String DO_LOGIN = '/user/pwd-modify';//修改用户 密码
//  static const String DO_LOGIN = '/user/pwd-reset';//重置密码
//  static const String DO_LOGIN = '/sms/verify-code';//获取验证码
//  static const String DO_LOGIN = '/user/register';//注册
//  static const String DO_LOGIN = '/fence/add-fence';//添加围栏
//  static const String DO_LOGIN = '/fence/set-fence';//修改围栏
//  static const String DO_LOGIN = '/fence/remove-fence';//删除围栏
//  static const String DO_LOGIN = '/track/history-tracks';//查询历史轨迹
//  static const String DO_LOGIN = '/instruction/historys';//指令历史记录
//  static const String DO_LOGIN = '/instruction/send';//发送指令
//  static const String DO_LOGIN = '/dev/get-dev-config';//查询设备参数
//  static const String DO_LOGIN = '/dev/update-dev';//修改设备信息
//  static const String DO_LOGIN = '/user/modify-user';//修改图片


  //登录
  static Future Login(Map<String, Object> data) async {

    Map<String,dynamic> p = await getPamars();

    data['password'] = generateMd5(data['password']);

    var params = _params(data,  p['token'],  p['userId']);

    return $axios.from('/user/login', params);
  }

  //获取所以设备数据
  static Future getTracks() async {
    Map<String, dynamic> data = new Map<String, dynamic>();

    Map<String,dynamic> p = await getPamars();

    var params = _params(data, p['token'],  p['userId']);

    return $axios.from('/track/get-tracks', params);
  }

  //上传或修改头像
  static Future updateImage(Map<String, Object> data,image) async {

    Map<String,dynamic> p = await getPamars();

    var params = _params(data, p['token'],  p['userId']);

    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);

    params['file'] = new UploadFileInfo(new File(path), name,
        contentType: ContentType.parse("image/$suffix"));

     print(params);

    FormData formData = new FormData.from(params);

    return $axios.post('/user/modify-user', formData);

  }

  //获取报警信息列表
  static Future getAlarmList(Map<String, Object> data) async {

    Map<String,dynamic> p = await getPamars();

    var params = _params(data, p['token'],  p['userId']);

    return $axios.from('/alarm/get-alarms', params);
  }

  //获取用户信息
  static Future modifyUser(Map<String, Object> data) async {

    Map<String,dynamic> p = await getPamars();

    var params = _params(data, p['token'],  p['userId']);

    return $axios.from('/user/modify-user', params);
  }


  /*必要参数获取*/
  static getPamars() async {
    var token = await $auth.getToken();
    var  userId = await $auth.getUserId();
    return {'token':token,'userId':userId};
  }
}

//公共参数处理函数
Map<String, Object> _params(
    Map<String, Object> param, String token, String userId) {
  //是否有token
  if (token != '' && token != null) {
    param['userId'] = userId;
  }

  // ignore: non_constant_identifier_names
  var JSON = const JsonCodec();

  //参数配置
  var params = {
    'args': JSON.encode(param),
    'language': 'CN', //ES,US
    'tm': DateTime.now().millisecondsSinceEpoch,
    'token': token,
    'version': 1
  };
  if (params['token'] == '' || token == null) {
    params.remove('token');
  }

  //secret 加密
  var secret = '';

  params.forEach((key, value) {
    secret += key + value.toString();
  });

  if (token != '' && token != null) secret += token;
  params['secret'] = generateMd5(secret).toUpperCase();

  return params;
}

// md5 加密
String generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var digest = md5.convert(content);
  // 这里其实就是 digest.toString()
  return hex.encode(digest.bytes);
}
