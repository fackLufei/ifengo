import 'package:flutter/material.dart';
import 'package:ifengo/locale/Localizations.dart';

class XhDialog {
  /**
   * 普通消息
   */
  static messageConfirm(BuildContext context, String text, Function onConfirm) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 121,
              width: MediaQuery.of(context).size.width * 0.65,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 75,
                    child: Center(
                      child: Text(text),
                    ),
                  ),
                  Divider(color: Color.fromRGBO(228, 228, 228, 1), height: 1.0),
                  Container(
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: onConfirm,
                            child: Container(
                              child: Center(
                                child: Text(
                                  I18n.of(context).$t('define'),
                                  style:
                                      TextStyle(color: Colors.lightBlueAccent),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    right: BorderSide(
                                        color: Color.fromRGBO(228, 228, 228, 1),
                                        width: 0.5)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: Text(I18n.of(context).$t('cancel')),
                            ),
                          ),
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
