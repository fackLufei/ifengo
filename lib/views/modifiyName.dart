import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifengo/bean/user_data.dart';
import 'package:ifengo/components/Loading.dart';
import 'package:ifengo/store/app/AppState.dart';
import 'package:ifengo/store/module/user/action.dart';
import 'package:redux/redux.dart';
import 'package:ifengo/api/api.dart';
import 'package:ifengo/utils/index.dart';
import 'dart:convert';

class ModifiyName extends StatefulWidget{

  @override
  State<ModifiyName> createState() => ModifiyNameState();

}

class ModifiyNameState extends  State<ModifiyName>{

  /*账号密码*/
  TextEditingController Nickname = new TextEditingController();

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
         appBar: AppBar(
           title: Text('修改昵称'),
           centerTitle: true,
         ),
        body: Column(
          children: <Widget>[
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              margin: EdgeInsets.only(bottom: 20.0),
              color: Colors.white,
              child: TextField(
                  controller: Nickname,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  cursorColor: Colors.grey,
                  cursorWidth: 1,
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                      hintText: '请输入昵称',
                      hintStyle: TextStyle(color: Colors.grey))),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: StoreConnector<AppState, Store<AppState>>(
                  converter: (store) => store,
                  builder: (context, store) {
                    return RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 9.0),
                      color: Colors.lightBlueAccent,
                      textColor: Colors.white,
                      child: Text(
                        '保存',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onPressed: () {
                         if(Nickname.text==''){
                           return Utils.showToast('昵称不能为空');
                         }
                       //请求等待loading
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return new LoadingDialog(
                                text: '修改中',
                              );
                            });
                         Api.modifyUser({"nickName":Nickname.text}).then((data){
                           //关闭loading
                           Navigator.of(context).pop();
                           //将Responces<dynamic> 转化为 Map 数据
                           var result = json.decode(data.toString());
                           //code为零代码请求成功 后台数据规定状态码
                           if (result['code'] == 0) {
                             //用户信息序列化
                             UserData user = new UserData.fromJson(result['data']);
                             //回调
                             store.dispatch(UserAllAction(
                                 headPicPath: user.userInfo.headPicPath,
                                 nickName: user.userInfo.nickName,
                                 phone: user.userInfo.phone));
                             Utils.showToast('修改成功');
                             //跳转页面
                             Navigator.pop(context);
                           } else {
                             Utils.showToast('修改失败');
                           }
                         });
                      },
                    );
                  },
                ))
          ],
        ),
      );
    }
}