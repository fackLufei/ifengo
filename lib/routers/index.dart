
import 'package:ifengo/views/main/index.dart';
import 'package:ifengo/views/login.dart';
import 'package:ifengo/views/personal/personal.dart';
import 'package:ifengo/views/modifiyName.dart';
import 'package:ifengo/views/modifiyPassword.dart';

 class Routes {

    static  var routes = {

      "MainApp":(context)=>MainApp(),//定位
      "Login":(context)=>Login(),//登录
      "Personal":(context)=>Personal(),//登录
      "ModifiyName":(context)=>ModifiyName(),//修改昵称
      "ModifiyPassword":(context)=>ModifiyPassword()//修改密码

    };

 }