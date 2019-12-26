import 'package:flutter/material.dart';
import 'package:ifengo/utils/Icon.dart';
import 'package:ifengo/components/ToolsItem.dart';
import 'package:ifengo/bean/tracks_data.dart';

class DeviceItem extends StatelessWidget {
 final int currIndex;
 final int index;
 final Function setCurrIndex;
 final tracksData data;

  DeviceItem(this.currIndex, this.index, this.setCurrIndex,this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  'assets/images/mycar_front_${data.ico}_n.png',
                  width: 50.0,
                  height: 50.0,
                  color: Colors.grey,
                  colorBlendMode: data.online==0?BlendMode.color:BlendMode.dst,
                ),
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  setCurrIndex(index);
                },
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(data.macName),
                      Text(
                        'IMEI:${data.macId}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(
                  UserIcon.track,
                  color: Colors.green,
                  size: 30,
                ),
              )
            ],
          ),
          Offstage(
              offstage:currIndex != index,
              child: ToolsItem(),
          )
        ],
      ),
    );
  }
}
