//UI相关
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
//初始化页面
import 'package:ifengo/views/login.dart';
import 'package:ifengo/views/main/index.dart';
//路由管理
import 'package:ifengo/routers/index.dart';
//工具类使用 ---校验登录状态
import 'package:ifengo/utils/index.dart';
//全局状态管理
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ifengo/store/index.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifengo/store/app/AppState.dart';
//国际化
import 'package:ifengo/locale/LocalizationsDelegate.dart';
import 'package:ifengo/locale/Localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp>{

  bool _hasLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 判断是否已经登录
   Utils.isLogin().then((data){
      setState(() {
        _hasLogin = data!=null;
      });
   });
  }

  @override
  Widget build(BuildContext context) {
    //沉浸式状态栏
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }

    // TODO: implement build
    return StoreProvider<AppState>(
      store: createStore(), //StoreProvider 接受一个state
      child:   MaterialApp(
        routes: Routes.routes,//路由注册
        onGenerateTitle: (context){                                              // 此处
          return I18n.of(context).$t('task title');
        },
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          I18nLocalizationsDelegate.delegate
        ],
        supportedLocales: [
          const Locale('zh','CH'),
          const Locale('en','US'),
          // ... other locales the app supports
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: showWelcomePage(),
      )
    );
  }



  //app页面显示判断
  showWelcomePage() {
      return _hasLogin? MainApp():Login();
  }

}






