import 'package:flutter/material.dart';
import 'package:ifengo/utils/Icon.dart';
import 'package:ifengo/components/ToolsItem.dart';
import 'dart:math' as math;
import 'package:ifengo/bean/tracks_data.dart';

class DeviceSwiperItem extends StatelessWidget {

  final tracksData data;
  final Function setOpenChange;

  DeviceSwiperItem(this.data,this.setOpenChange);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(3.0)),
                    child: Text(data.macName,
                        style: TextStyle(color: Colors.white)),
                  ),
                  Text(
                    '离线',
                    style: TextStyle(color: Colors.redAccent),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    UserIcon.instrument_panel,
                    color: Colors.lightBlue,
                    size: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 15.0),
                    child: Text('${data.speed}km/h'),
                  ),
                  GestureDetector(
                   onTap: (){
                     setOpenChange();
                   },
                    child: Transform.rotate(
                      child: Icon(
                        UserIcon.arrowRight,
                        color: Colors.lightBlue,
                        size: 25,
                      ),
                      angle: math.pi / 2,
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              //中间部分
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Icon(
                        UserIcon.ignition,
                        size: 22,
                        color: Colors.lightBlue,
                      ),
                    ),
                    Text('点火')
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(UserIcon.gps, color: Colors.lightBlue),
                    Text('GPS')
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(UserIcon.battery, color: Colors.lightBlue),
                    Text('100%')
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(UserIcon.car_door, color: Colors.lightBlue),
                    Text('打开')
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 5.0, left: 5.0),
                    child: Icon(UserIcon.location, color: Colors.lightBlue),
                  ),
                  Text('2019-07-30 17:16:20',style: TextStyle(fontSize: 12.0),)
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(
                      UserIcon.signal,
                      color: Colors.lightBlue,
                      size: 23,
                    ),
                  ),
                  Text('2019-07-30 17:16:20',style: TextStyle(fontSize: 12.0),)
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0,left: 10.0),
            child: Text.rich(
                TextSpan(children: [
                  TextSpan(text: '位置：'),
                  TextSpan(text: '查看地址',style: TextStyle(color: Colors.green))
             ])
            ),
          ),
          ToolsItem()
        ],
      ),
    );
  }
}
