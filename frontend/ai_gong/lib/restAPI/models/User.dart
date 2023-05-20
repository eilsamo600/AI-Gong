class User {
  String? nickname;
  String? email;
  String? imageUrl;

  User({this.email, this.nickname, this.imageUrl});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    nickname = json['nickname'];
    imageUrl = json['imageUrl'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['nickname'] = nickname;
    data['imageUrl'] = imageUrl;

    return data;
  }
}
