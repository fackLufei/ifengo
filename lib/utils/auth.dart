
import 'package:shared_preferences/shared_preferences.dart';

class Auth{


  Auth._internal();
  //保存单例
  static Auth _auth = new Auth._internal();

  //工厂构造函数
  factory Auth()=> _auth;

//token
  Future setToken(String data){
   return setShared('token',data);
 }

   Future getToken(){
     return getShared('token');
 }
//userId
  Future setUserId(String data){
   return setShared('userId',data);
  }

  Future getUserId() async{
    return getShared('userId');
  }

  setUserInfo(List<String> data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('UserInfo', data);
    print('UserInfo 存储值为 $data');
  }

  Future getUserInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data  = prefs.getStringList('UserInfo');
    return data;
  }

  loginOut() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userId');
  }

}

Future getShared(String key) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String data  = prefs.getString(key);
     return data;
  }

Future setShared(String key,String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key,data);
    print('$key 存储值为 $data');
  }




//定义一个top-level变量，页面引入该文件后可以直接使用auth
Auth $auth = new Auth();

