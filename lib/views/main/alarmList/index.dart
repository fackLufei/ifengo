import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifengo/locale/Localizations.dart';
import 'package:ifengo/bean/alarms_data.dart';
import 'package:ifengo/utils/Icon.dart';
import 'package:ifengo/api/api.dart';
import 'dart:convert';
import 'package:common_utils/common_utils.dart';

class AlarmList extends StatefulWidget {
  @override
  State<AlarmList> createState() => AlarListState();
}

class AlarListState extends State<AlarmList> {
  List<Alarm> alarmsList = []; //报警信息数据

  num lastId = 0; //最后一项Id用于拉去更多数据集

  final num pageNum = 50; //每页请求数量

  num macId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlarmsData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).$t('alarm msg'),style: TextStyle(fontSize: 18.0),),
      ),
      body: RefreshIndicator(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Icon(
                          UserIcon.alarm,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('IMEI：${alarmsList[index].macId}'),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.0, horizontal: 6.0),
                                  margin: EdgeInsets.only(right: 8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(3.0)),
                                  child: Text(alarmsList[index].macName,
                                      style: TextStyle(color: Colors.white)),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('${alarmsList[index].fenceName}：电子围栏驶出报警'),
                                Text(DateUtil.formatDateMs(alarmsList[index].alarmDate, format: "yyyy/MM/dd HH:mm:ss"))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.grey, height: 1.0);
              },
              itemCount: alarmsList.length),
          onRefresh: () async{
           await getAlarmsData();
          }),
    );
  }

  Future getAlarmsData() async {
    Map<String, Object> params = {'lastId': lastId, 'pageNum': pageNum};

    if (macId != null) {
      params['macId'] = macId;
    }

    var respones = await Api.getAlarmList(params);

       print(respones);

    var result = json.decode(respones.toString());

    AlarmsData alarmsData = AlarmsData.fromJson(result);

    if (alarmsData.code == 0) {
      setState(() {
        alarmsList = alarmsData.data;
      });
    }
  }
}
