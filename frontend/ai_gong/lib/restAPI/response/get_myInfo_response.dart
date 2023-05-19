import '../models/User.dart';

class MyInfoResponse {
  User? user;
  MyInfoResponse({this.user});

  MyInfoResponse.fromJson(Map<String, dynamic> json) {
    // myInfo = MyInfo.fromJson(json);
  }
}
