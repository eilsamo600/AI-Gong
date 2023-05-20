import 'package:ai_gong/restAPI/models/User.dart';

class UserResponse {
  User? user;

  UserResponse({this.user});

  UserResponse.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json);
  }
}
