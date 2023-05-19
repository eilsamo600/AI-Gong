class User {
  String? nickname;
  String? email;

  User({this.email, this.nickname});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    nickname = json['nickname'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['nickname'] = nickname;

    return data;
  }
}
