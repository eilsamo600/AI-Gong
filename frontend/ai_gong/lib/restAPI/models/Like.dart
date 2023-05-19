class Like {
  String? email;
  String? className;

  Like({this.email, this.className});

  Like.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    className = json['className'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['className'] = className;
    return data;
  }
}
