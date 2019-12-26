import 'package:ifengo/store/module/user/state.dart';
import 'package:ifengo/store/module/tracks/state.dart';

class AppState {
  final UserState userState;
  final TracksState tracksState;
  AppState({
    this.userState,
    this.tracksState
  });

  factory AppState.initial(){
    return AppState(
        userState: UserState.initState(),
        tracksState:TracksState.initState()
    );
  }
}