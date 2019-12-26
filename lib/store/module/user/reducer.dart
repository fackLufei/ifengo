import 'package:redux/redux.dart';
import 'state.dart';
import 'action.dart';
import 'package:ifengo/utils/auth.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState,HeadImgAction>(_token),
  TypedReducer<UserState,NickNameAction>(_userId),
  TypedReducer<UserState,UserAllAction>(_userAll),
]);


UserState _token(UserState state,HeadImgAction action){
  state.headPicPath = action.headPicPath;
  return state;
}

UserState _userId(UserState state,NickNameAction action){
  state.nickName = action.nickName;
  return state;
}

UserState _userAll(UserState state,UserAllAction action){
  state.nickName = action.nickName;
  state.headPicPath = action.headPicPath;
  state.phone = action.phone;
  //存储到本地
  $auth.setUserInfo([action.nickName,action.headPicPath,action.phone]);
  return state;
}
