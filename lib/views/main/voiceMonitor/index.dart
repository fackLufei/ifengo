import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifengo/locale/Localizations.dart';

class VoiceMonitor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('voiceMonitor'),
      ),
      body: Center(
          child:Text(I18n.of(context).$t('task title'))
      ),
    );
  }
}