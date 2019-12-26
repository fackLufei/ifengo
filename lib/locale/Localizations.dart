import 'package:flutter/material.dart';

class I18n {

  final Locale locale;

  I18n(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'task title': 'Flutter Demo',
    },
    'zh': {
      'task title': 'Flutter 示例',
      'hint account':'请输入账号',
      'hint password':'请输入密码',
      'login':'登录',
      'forget password':'忘记密码?',
      'new register':'新用户注册',
      'account empty':'登录账号不能为空',
      'password empty':'登录密码不能为空',
      'login loading':'账号登录中…',
      'login success':'登录成功',
      'login err':'账号或密码不匹配',
      'location':'定位',
      'device list':'列表',
      'alarm msg':'报警信息',
      'monitor voice':'声音监听',
      'all':'全部',
      'on line':'在线',
      'on off':'离线',
      'not active':'未激活',
      'navigation':'导航',
      'trajectory':'轨迹',
      'enclosure':'围栏',
      'instructions':'指令',
      'alarm':'警报',
      'sim':'SIM',
      'refresh Success':'刷新成功',
      'personal':'个人中心',
      'user name':'姓名',
      'head portrait':'头像',
      'account':'账号',
      'change password':'修改密码',
      'wechat':'微信',
      'mapping':'设置地图',
      'message center':'消息中心',
      'about us':'关于我们',
      'determine to quit':'确定退出？',
      'Sign out':'退出账号',
      'Photograph':'拍照',
      'Choose Photos':'选择照片',
      'define':'确定',
      'cancel':'取消',
      'Successful revision':'修改成功',
      'Modification failed':'修改失败',
    }
  };

  String $t(String text){
    return _localizedValues[locale.languageCode][text];
  }

  //此处
  static I18n of(BuildContext context){
    return Localizations.of(context, I18n);
  }

}