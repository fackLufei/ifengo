import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifengo/components/DeviceItem.dart';
import 'package:ifengo/bean/tracks_data.dart';
import 'package:ifengo/store/app/AppState.dart';
import 'package:redux/redux.dart';
import 'package:ifengo/utils/index.dart';
import 'package:ifengo/locale/Localizations.dart';

class PageDevice extends StatefulWidget {
  final List<tracksData> deviceList;

  PageDevice(this.deviceList);

  @override
  State<PageDevice> createState() => PageDeviceState();
}
// 混合 AutomaticKeepAliveClientMixin   作用保存页面状态 不会每次进入都重新渲染
class PageDeviceState extends State<PageDevice>  with AutomaticKeepAliveClientMixin {
  int currIndex;

  void setCurrIndex(int index) {
    setState(() {
      currIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);// 混合 AutomaticKeepAliveClientMixin 必须执行 否则路由其它页面返回时又会重新渲染
    // TODO: implement build
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      builder: (context, store) {
        return RefreshIndicator(
          child: ListView.separated(
              itemCount: widget.deviceList.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.grey, height: 1.0);
              },
              itemBuilder: (context, index) {
                return DeviceItem(
                    currIndex, index, setCurrIndex, widget.deviceList[index]);
              }),
          onRefresh: () async{
             await Utils.getTracks(store,context);
             Utils.showToast(I18n.of(context).$t('refresh Success'));
          },
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
