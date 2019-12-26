import 'package:flutter/material.dart';
import 'package:ifengo/utils/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ifengo/api/api.dart';
import 'package:ifengo/bean/tracks_data.dart';
import 'dart:convert';
import 'package:ifengo/store/module/tracks/action.dart';

class Utils {
  static Future isLogin() async {
    return $auth.getUserId();
  }

  static void showToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future getTracks(store,context) async {
    try {
      var data = await Api.getTracks();
      var result = json.decode(data.toString());
      if (result['code'] == 0) {
        //用户信息序列化
        List<tracksData> list = gettracksDataList(result['data']);
        store.dispatch(TracksUpdateAction(list));
      }else{
        await $auth.loginOut();
        Navigator.pushReplacementNamed(context, 'Login');
      }
    } catch (e) {
      print('getTracks ===> $e');
    }
  }
}
