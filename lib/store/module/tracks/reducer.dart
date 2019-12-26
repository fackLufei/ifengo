import 'package:redux/redux.dart';
import 'state.dart';
import 'action.dart';
import 'package:ifengo/bean/tracks_data.dart';

final tracksTeducer = combineReducers<TracksState>(
    [TypedReducer<TracksState, TracksUpdateAction>(_update)]);

TracksState _update(TracksState state, TracksUpdateAction action) {
  state.trackList = action.trackList;
  _filter(action.trackList,state);
  return state;
}

_filter(List<tracksData> list, TracksState state) {
  List<tracksData> online = [];
  List<tracksData> offline = [];
  List<tracksData> notActive = [];
  list.forEach((item) {
    if (item.ico < 0 || item.ico > 8) {
      item.ico = 0;
    }
    ++item.ico;
    if (item.activate == 0) {
      notActive.add(item);
    } else if (item.online == 1) {
      online.add(item);
    } else if (item.online == 0) {
      offline.add(item);
    }
  });
  state.notActive = notActive;
  state.offline = offline;
  state.online = online;
}
