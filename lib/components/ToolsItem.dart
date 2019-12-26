import 'package:flutter/material.dart';
import 'package:ifengo/utils/Icon.dart';
import 'package:ifengo/locale/Localizations.dart';

class ToolsItem extends StatelessWidget {
  final num iconSize = 25.0;

  final List<Tools> toolsList = [
    Tools(Colors.green, 'navigation', UserIcon.navigation),
    Tools(Colors.orange, 'trajectory', UserIcon.trajectory),
    Tools(Colors.lightBlue, 'enclosure', UserIcon.enclosure),
    Tools(Colors.cyanAccent, 'instructions', UserIcon.instructions),
    Tools(Colors.deepOrange, 'alarm', UserIcon.alarm),
    Tools(Colors.indigoAccent, 'sim', UserIcon.sim)
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: toolsList.map((Tools tool) {
          return GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  tool.icon,
                  color: tool.color,
                  size: iconSize,
                ),
                Text(
                  I18n.of(context).$t(tool.text),
                  style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1)),
                )
              ],
            ),
            onTap: () {
              print(tool.text);
            },
          );
        }).toList(),
      ),
    );
  }
}

/*Tools 实体类*/
class Tools {
  Color color;
  String text;
  IconData icon;

  Tools(this.color, this.text, this.icon);
}
