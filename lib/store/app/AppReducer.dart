import 'AppState.dart';
import 'package:ifengo/store/module/user/reducer.dart';
import 'package:ifengo/store/module/tracks/reducer.dart';

AppState appReducer(AppState state, dynamic action) =>
    new AppState(
        userState: userReducer(state.userState,action),
        tracksState: tracksTeducer(state.tracksState,action),
    );