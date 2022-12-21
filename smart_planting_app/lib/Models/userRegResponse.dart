class UserRegResponse {
  int? userID;

  UserRegResponse({this.userID});

  UserRegResponse.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = userID;
    return data;
  }
}
