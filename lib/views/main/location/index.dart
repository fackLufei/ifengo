import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifengo/utils/Icon.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ifengo/locale/Localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifengo/store/app/AppState.dart';
import 'package:ifengo/utils/auth.dart';
import 'package:ifengo/store/module/user/action.dart';
import 'package:amap_base/amap_base.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ifengo/components/deviceSwiperItem.dart';
import 'package:redux/redux.dart';
import 'package:ifengo/bean/tracks_data.dart';

class Location extends StatefulWidget {
  @override
  State<Location> createState() => LocationState();
}

class LocationState extends State<Location> with AutomaticKeepAliveClientMixin {
  String barcode = '';
  AMapController _controller;
  bool isOpenSwiper = true;
  var marker = MarkerOptions(
      position: LatLng(41.851827, 112.801637),
      icon: 'assets/images/mycar_front_2_n.png' //静态资源地址
      );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      onInit: (store) async {
        if (store.state.userState.phone == '') {
          List<String> data = await $auth.getUserInfo();
          if (data != null) {
            store.dispatch(UserAllAction(
                nickName: data[0], headPicPath: data[1], phone: data[2]));
          }
        }
      },
      builder: (context, store) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'Personal');
              },
              child: Hero(
                  tag: 'avatar',
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: store.state.userState.headPicPath != ''
                                ? NetworkImage(
                                    store.state.userState.headPicPath)
                                : AssetImage(
                                    'assets/images/default_avatar.png'),
                            fit: BoxFit.cover)),
                  )),
            ),
            title: Text(I18n.of(context).$t('location')),
            centerTitle: true,
            actions: <Widget>[
              GestureDetector(
                onTap: scan,
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(UserIcon.scan, color: Colors.white),
                ),
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              AMapView(
                onAMapViewCreated: (controller) {
                  _controller = controller;
//                  _controller.addMarker(MarkerOptions(
//                      position: LatLng(41.851827, 112.801637),
//                      isFlat: false,
//                      icon:'assets/images/mycar_front_1_n.png'
//                     )
//                  );
                  Future.delayed(Duration(seconds: 2)).then((e) {
                    markerInit(store.state.tracksState.trackList, controller);
                  });
                },
                amapOptions: AMapOptions(
                  compassEnabled: false,
                  zoomControlsEnabled: false,
                  logoPosition: LOGO_POSITION_BOTTOM_CENTER,
                  camera: CameraPosition(
                    target: LatLng(41.851827, 112.801637),
                    zoom: 4,
                  ),
                ),
              ),
              Positioned(
                //设备轮播展示
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 205,
                  child: Transform.translate(
                    offset: Offset(0.0, isOpenSwiper ? 0 : 155.0),
                    child: new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return DeviceSwiperItem(
                              store.state.tracksState.trackList[index],
                              setOpenChange);
                        },
                        loop: false,
                        itemCount: store.state.tracksState.trackList.length),
                  ),
                ),
                bottom: 0,
                left: 0,
              )
            ],
          ),
        );
      },
    );
  }

  //设备详情  展开缩放
  void setOpenChange() {
    setState(() {
      isOpenSwiper = !isOpenSwiper;
    });
  }

  //渲染标记
  void markerInit(List<tracksData> list, AMapController _controller) {
    print('执行了');

    List<MarkerOptions> markerList = [];

    list.forEach((item) {
      if (item.x > 0 && item.y > 0) {
        markerList.add(MarkerOptions(
            position: LatLng(item.y, item.x),
            icon: 'assets/images/mycar_top_9_n.png',
            snippet: item.macName,
            infoWindowEnable:true,
            title: item.macName));
      } else {
        markerList.add(MarkerOptions(
            position: LatLng(22.5962, 114.0000103),
            icon: 'assets/images/mycar_top_9_n.png',
            snippet: item.macName,
            title: item.macName));
      }
    });

    _controller.addMarkers(markerList);

    Stream<MarkerOptions>  markerClickedEvent =  _controller.markerClickedEvent;

    markerClickedEvent.listen((data){
      print('data ===>  $data');
    });

    print('结束了');
  }

  Future scan() async {
    var result = await FlutterBarcodeScanner.scanBarcode("#ffff00", '小黑', true);
    setState(() {
      barcode = result;
    });
    print('barcodeScanRes = $barcode');
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
