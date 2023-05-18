import 'package:ai_gong/restAPI/models/MyInfo.dart';

class MyReservationListResponse {
  List<MyInfo>? myInfo;

  MyReservationListResponse({this.myInfo});

  MyReservationListResponse.fromJson(List<dynamic> jsonList) {
    if (jsonList.isNotEmpty) {
      myInfo = <MyInfo>[];
      for (var v in jsonList) {
        // myInfo!.add(MyInfo.fromJson(v));
      }
    }
  }
}
