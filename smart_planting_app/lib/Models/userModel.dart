class UserModel {
  String? userName;
  String? email;
  String? mobileNo;
  String? userPassword;
  String? joinDate;

  UserModel(
      {this.userName,
        this.email,
        this.mobileNo,
        this.userPassword,
        this.joinDate});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    userPassword = json['userPassword'];
    joinDate = json[DateTime.now().toString()];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = userName;
    data['email'] = email;
    data['mobileNo'] = mobileNo;
    data['userPassword'] = userPassword;
    data['joinDate'] = '2022-12-15 06:05:26';
    return data;
  }
}
