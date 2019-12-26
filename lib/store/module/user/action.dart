class HeadImgAction{
  String headPicPath;
  HeadImgAction({String headPicPath}){
    this.headPicPath = headPicPath??'';
  }
}

class NickNameAction{
  String nickName;
  NickNameAction({String nickName}){
    this.nickName = nickName??'';
  }
}

class UserAllAction{
  String headPicPath;
  String nickName;
  String phone;
  UserAllAction({String headPicPath='',String nickName='',String phone=''}){
    this.nickName = nickName;
    this.headPicPath = headPicPath;
    this.phone = phone;
  }
}