
import 'package:ifengo/bean/tracks_data.dart';

class TracksState {

  List<tracksData> trackList;
  List<tracksData> online;
  List<tracksData> offline;
  List<tracksData> notActive;

  TracksState(this.trackList,this.online,this.offline,this.notActive);

  TracksState.initState() {
    trackList = [];
    online = [];
    offline = [];
    notActive = [];
  }
}