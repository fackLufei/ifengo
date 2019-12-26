import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifengo/bean/user_data.dart';
import 'package:ifengo/components/Loading.dart';
import 'package:ifengo/store/app/AppState.dart';
import 'package:ifengo/store/module/user/action.dart';
import 'package:ifengo/locale/Localizations.dart';
import 'package:ifengo/utils/Icon.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ifengo/components/XhDialog.dart';
import 'package:ifengo/utils/auth.dart';
import 'package:ifengo/api/api.dart';
import 'package:ifengo/utils/index.dart';
import 'package:redux/redux.dart';
import 'dart:convert';

class Personal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
            appBar: AppBar(
              title: Text(I18n.of(context).$t('personal')),
              centerTitle: true,
            ),
            body: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'ModifiyName');
                  },
                  child: PersonalItem(
                      title: I18n.of(context).$t('user name'),
                      icon: UserIcon.username,
                      color: Colors.blue,
                      info: store.state.userState.nickName),
                ),
                PersonalDivider(),
                GestureDetector(
                  onTap: () {
                    showGetImageToast(context, store);
                  },
                  child: PersonalHeadImage(I18n.of(context).$t('head portrait'),
                      store.state.userState.headPicPath),
                ),
                PersonalDivider(),
                PersonalItem(
                  title: I18n.of(context).$t('account'),
                  icon: UserIcon.phone,
                  color: Colors.greenAccent,
                  info: store.state.userState.phone,
                  isRight: false,
                ),
                PersonalDivider(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'ModifiyPassword');
                  },
                  child: PersonalItem(
                      title: I18n.of(context).$t('change password'),
                      icon: UserIcon.edit,
                      color: Colors.cyan),
                ),
                PersonalDivider(),
                PersonalItem(
                    title: I18n.of(context).$t('wechat'),
                    icon: UserIcon.WeChat,
                    color: Colors.green),
                Container(
                  height: 20.0,
                ),
                PersonalItem(
                    title: I18n.of(context).$t('mapping'),
                    icon: UserIcon.username,
                    color: Colors.cyanAccent),
                PersonalDivider(),
                PersonalItem(
                    title: I18n.of(context).$t('message center'),
                    icon: UserIcon.short_message,
                    color: Colors.yellow),
                PersonalDivider(),
                PersonalItem(
                    title: I18n.of(context).$t('about us'),
                    icon: UserIcon.Tips,
                    color: Colors.green),
                Container(
                  height: 20.0,
                ),
                GestureDetector(
                    onTap: () {
                      XhDialog.messageConfirm(
                          context, I18n.of(context).$t('determine to quit'),
                          () async {
                        await $auth.loginOut();
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'Login', (Route<dynamic> route) => false);
                      });
                    },
                    child: PersonalItem(
                        title: I18n.of(context).$t('Sign out'),
                        icon: UserIcon.shutdown,
                        color: Colors.redAccent))
              ],
            ),
            resizeToAvoidBottomPadding: false,
          );
        });
  }

  //头像相关
  void showGetImageToast(context, store) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 101,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    updateImage(ImageSource.camera, context, store);
                  },
                  child: Container(
                    height: 50,
                    color: Colors.white,
                    child:
                        Center(child: Text(I18n.of(context).$t('Photograph'))),
                  ),
                ),
                Divider(color: Color.fromRGBO(228, 228, 228, 1), height: 1.0),
                GestureDetector(
                  onTap: () {
                    updateImage(ImageSource.gallery, context, store);
                  },
                  child: Container(
                    height: 50,
                    color: Colors.white,
                    child: Center(
                        child: Text(I18n.of(context).$t('Choose Photos'))),
                  ),
                ),
              ],
            ),
          );
        });
  }

  //修改头像统一入口处理
  void updateImage(ImageSource type, context, store) async {
    var image = await ImagePicker.pickImage(source: type);

    if (image == null) {
      return Utils.showToast('修改失败');
    }

    //请求loading
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '修改中...',
          );
        });

    Api.updateImage({"iconId": 14}, image).then((data) async {
      Navigator.of(context).pop();
      //将Responces<dynamic> 转化为 Map 数据
      var result = json.decode(data.toString());
      //code为零代码请求成功 后台数据规定状态码
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
        Utils.showToast(I18n.of(context).$t('Successful revision'));
        Navigator.pop(context);
      } else {
        Utils.showToast(I18n.of(context).$t('Modification failed'));
        Navigator.pop(context);
      }
    });
  }
}

//PersonalItem
class PersonalItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String info;
  final bool isRight;
  final Color color;

  PersonalItem(
      {this.title = '',
      this.icon,
      this.color,
      this.info = '',
      this.isRight = true});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 60.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                color: color,
              ),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text(title),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(info),
              ),
              Offstage(
                offstage: !isRight,
                child: Icon(
                  UserIcon.arrowRight,
                  size: 20,
                  color: Color.fromRGBO(228, 228, 228, 1),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

//PersonalDivider
class PersonalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Divider(color: Color.fromRGBO(228, 228, 228, 1), height: 1.0),
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
      color: Colors.white,
    );
  }
}

class PersonalHeadImage extends StatelessWidget {
  final String title;
  final String images;

  PersonalHeadImage(this.title, this.images);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 20.0),
      height: 60.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Hero(
                  tag: 'avatar',
                  child: Container(
                    height: 45.0,
                    width: 45.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: images != ''
                                ? NetworkImage(images)
                                : AssetImage(
                                    'assets/images/default_avatar.png'),
                            fit: BoxFit.cover)),
                  )),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(title),
              )
            ],
          ),
          Icon(
            UserIcon.arrowRight,
            size: 20,
            color: Color.fromRGBO(228, 228, 228, 1),
          )
        ],
      ),
    );
    ;
  }
}
