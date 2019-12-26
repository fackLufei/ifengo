import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifengo/store/app/AppState.dart';
import 'package:ifengo/utils/index.dart';
import 'package:ifengo/api/api.dart';
import 'package:ifengo/bean/user_data.dart';
import 'dart:convert';
import 'package:ifengo/utils/auth.dart';
import 'package:ifengo/locale/Localizations.dart'; //国际化
import 'package:redux/redux.dart';
import 'package:ifengo/store/module/user/action.dart';
import 'package:ifengo/components/Loading.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  /*账号密码*/
  TextEditingController _Account = new TextEditingController();
  TextEditingController _Password = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Wrap(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(94, 95, 243, 1),
                    Color.fromRGBO(73, 180, 254, 1)
                  ]),
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 85.0,
                      height: 85.0,
                      child: Image.asset('assets/images/start_bg_2.png')),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.04),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                        borderRadius: BorderRadius.circular(3.0)),
                    child: TextField(
                        controller: _Account,
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        cursorColor: Colors.white,
                        cursorWidth: 1,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                            hintText: I18n.of(context).$t('hint account'),
                            hintStyle: TextStyle(color: Colors.white))),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                        borderRadius: BorderRadius.circular(3.0)),
                    child: TextField(
                        controller: _Password,
                        maxLength: 26,
                        cursorColor: Colors.white,
                        cursorWidth: 1,
                        obscureText: true,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                            hintText: I18n.of(context).$t('hint password'),
                            hintStyle: TextStyle(color: Colors.white))),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: StoreConnector<AppState, Store<AppState>>(
                        converter: (store) => store,
                        builder: (context, store) {
                          return RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 9.0),
                            color: Colors.white,
                            textColor: Colors.blue,
                            child: Text(
                              I18n.of(context).$t('login'),
                              style: TextStyle(fontSize: 18.0),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            onPressed: () {
                              login(_Account.text, _Password.text, store,
                                  context);
                            },
                          );
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01),
                    child: GestureDetector(
                      child: Text(
                        I18n.of(context).$t('forget password'),
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      onTap: forgetPassword,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.32,
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 1.0,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(255, 255, 255, .4)),
                  ),
                  GestureDetector(
                    child: Text(
                      I18n.of(context).$t('new register'),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    onTap: register,
                  )
                ],
              ),
            ),
          )
        ],
      ),
//      resizeToAvoidBottomPadding: false, //输入框抵住键盘,防止键盘弹出导致的内容溢出
    );
  }

  /*忘记密码*/
  void forgetPassword() {}

  /*新用户注册*/
  void register() {}
}

/*登录*/
void login(String account, String password, store, context) {
  if (account.trim() == '') {
    return Utils.showToast(I18n.of(context).$t('account empty'));
  }

  if (password.trim() == '') {
    return Utils.showToast(I18n.of(context).$t('password empty'));
  }
//请求等待loading
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
          text: I18n.of(context).$t('login loading'),
        );
      });
//调用登录接口
  Api.Login({"loginName": account, "password": password}).then((data) async {
    //关闭loading
    Navigator.of(context).pop();
    //将Responces<dynamic> 转化为 Map 数据
    var result = json.decode(data.toString());
    //code为零代码请求成功 后台数据规定状态码
    print(result);
    if (result['code'] == 0) {
      //用户信息序列化
      UserData user = new UserData.fromJson(result['data']);
      //保存用户登录信息
      await $auth.setToken(user.token);
      await $auth.setUserId(user.userInfo.id.toString());
      //回调
      store.dispatch(UserAllAction(
          headPicPath: user.userInfo.headPicPath,
          nickName: user.userInfo.nickName,
          phone: user.userInfo.phone));
      Utils.showToast(I18n.of(context).$t('login success'));
      //跳转页面
      Navigator.pushReplacementNamed(context, "MainApp");
    } else {
      Utils.showToast(I18n.of(context).$t('login err'));
    }
  });
}
