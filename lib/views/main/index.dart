import 'package:flutter/material.dart';
import 'package:ifengo/store/app/AppState.dart';
import 'package:ifengo/views/main/location/index.dart';
import 'package:ifengo/views/main/alarmList/index.dart';
import 'package:ifengo/views/main/deviceList/index.dart';
import 'package:ifengo/views/main/voiceMonitor/index.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifengo/utils/Icon.dart';
import 'package:ifengo/locale/Localizations.dart';
import 'package:redux/redux.dart';
import 'package:ifengo/utils/index.dart';


class MainApp extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<MainApp> {
  final List<Widget> list = List();//页面集合
  int _currentIndex = 0;//页面切换下标

  @override
  void initState() {
    list
      ..add(Location())
      ..add(DeviceList())
      ..add(AlarmList())
      ..add(VoiceMonitor());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        onInit: (store) async {
          await Utils.getTracks(store,context);
        },
        builder: (context, userState) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              // 底部导航
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(UserIcon.location),
                    title: Text(I18n.of(context).$t('location'))),
                BottomNavigationBarItem(
                    icon: Icon(UserIcon.list),
                    title: Text(I18n.of(context).$t('device list'))),
                BottomNavigationBarItem(
                    icon: Icon(UserIcon.short_message),
                    title: Text(I18n.of(context).$t('alarm msg'))),
                BottomNavigationBarItem(
                    icon: Icon(UserIcon.monitor),
                    title: Text(I18n.of(context).$t('monitor voice')))
              ],
              currentIndex: _currentIndex,
              fixedColor: Colors.blue,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
            ),
            body: IndexedStack(
              index: _currentIndex,
              children: list,
            ),
          );
        });
  }
  //切换函数
  void _onItemTapped(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
  }
}
