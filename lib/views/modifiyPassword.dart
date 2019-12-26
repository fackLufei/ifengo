import 'package:flutter/material.dart';


class ModifiyPassword extends StatefulWidget{


  @override
  State<ModifiyPassword> createState() => ModifiyPasswordState();



}

class ModifiyPasswordState extends State<ModifiyPassword>{

  TextEditingController oldPW = new TextEditingController();
  TextEditingController newPW = new TextEditingController();
  TextEditingController confirmPW = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('修改密码'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            color: Colors.white,
            child: TextField(
                controller: oldPW,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                cursorColor: Colors.grey,
                cursorWidth: 1,
                style: TextStyle(color: Colors.black54, fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    hintText: '请输入旧密码',
                    hintStyle: TextStyle(color: Colors.grey))),
          ),
          Divider(color: Color.fromRGBO(228, 228, 228, 1), height: 1.0),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            color: Colors.white,
            child: TextField(
                controller: newPW,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                cursorColor: Colors.grey,
                cursorWidth: 1,
                style: TextStyle(color: Colors.black54, fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    hintText: '请输入新密码',
                    hintStyle: TextStyle(color:  Colors.grey))),
          ),
          Divider(color: Color.fromRGBO(228, 228, 228, 1), height: 1.0),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            color: Colors.white,
            child: TextField(
                controller: confirmPW,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                cursorColor: Colors.grey,
                cursorWidth: 1,
                style: TextStyle(color: Colors.black54, fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                    hintText: '请输入确认密码',
                    hintStyle: TextStyle(color:  Colors.grey))),
          )
        ],
      ),
    );
  }

}