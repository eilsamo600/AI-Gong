import 'package:ai_gong/restAPI/models/Incubator.dart';

class MyReservationListResponse {
  List<Incubator>? incubators;

  MyReservationListResponse({this.incubators});

  MyReservationListResponse.fromJson(List<dynamic> jsonList) {
    if (jsonList.isNotEmpty) {
      incubators = <Incubator>[];
      for (var v in jsonList) {
        incubators!.add(Incubator.fromJson(v));
      }
    }
  }
}
