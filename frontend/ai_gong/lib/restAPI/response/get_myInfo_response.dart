import 'package:ai_gong/restAPI/models/MyInfo.dart';

class MyInfoResponse {
  MyInfo? myInfo;

  MyInfoResponse({this.myInfo});

  MyInfoResponse.fromJson(Map<String, dynamic> json) {
    // myInfo = MyInfo.fromJson(json);
  }
}
