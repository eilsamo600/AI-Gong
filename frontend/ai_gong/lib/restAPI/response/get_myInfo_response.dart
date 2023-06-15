import '../models/User.dart';

// Summary:
// MyInfoResponse is used to parse the response from the server
// This class is used in the controller
class MyInfoResponse {
  User? user;
  MyInfoResponse({this.user});

  MyInfoResponse.fromJson(Map<String, dynamic> json) {
    // myInfo = MyInfo.fromJson(json);
  }
}
