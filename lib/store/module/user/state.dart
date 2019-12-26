//第一步创建State
class UserState {
  String headPicPath;
  String nickName;
  String phone;

  UserState(this.headPicPath, this.nickName,this.phone);

  UserState.initState() {
    headPicPath = '';
    nickName = '';
    phone='';
  }

}