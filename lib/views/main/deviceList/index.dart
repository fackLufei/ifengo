import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifengo/locale/Localizations.dart';
import 'package:ifengo/components/PageDevice.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifengo/store/app/AppState.dart';
import 'package:ifengo/store/module/tracks/state.dart';

class DeviceList extends StatefulWidget {
  @override
  State<DeviceList> createState() => DeviceListState();
}

class DeviceListState extends State<DeviceList>
    with SingleTickerProviderStateMixin {
  //tabs 展示数据
  Map<String, num> mapTabs = {
    'all': 0,
    'on line': 0,
    'on off': 0,
    'not active': 0
  };
  //tabs 切换控制器
  TabController _tabController; //需要定义一个Controller

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: mapTabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, TracksState>(
        converter: (store) => store.state.tracksState,
        onDidChange: (store){
          setState(() {
            mapTabs = {
              'all': store.trackList.length,
              'on line': store.online.length,
              'on off': store.offline.length,
              'not active': store.notActive.length
            };
          });
        },
        builder: (context, tracksState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(I18n.of(context).$t('device list')),
              centerTitle: true,
              bottom: TabBar(
                  controller: _tabController,
                  tabs: mapTabs.keys
                      .map((e) =>
                      Tab(text: '${I18n.of(context).$t(e)}(${mapTabs[e]})'))
                      .toList()),
            ),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                PageDevice(tracksState.trackList),
                PageDevice(tracksState.online),
                PageDevice(tracksState.offline),
                PageDevice(tracksState.notActive)
              ],
            ),
          );
        });
  }
}
