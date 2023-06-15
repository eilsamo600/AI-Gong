import 'package:ai_gong/restAPI/models/User.dart';

// Summary:
// UserResponse is used to parse the response from the server
// This class is used in the controller
class UserResponse {
  User? user;

  UserResponse({this.user});

  UserResponse.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json);
  }
}
