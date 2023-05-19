import 'package:ai_gong/restAPI/models/Incubator.dart';

class MyReservationResponse {
  Incubator? incubators;

  MyReservationResponse({this.incubators});

  MyReservationResponse.fromJson(Map<String, dynamic> json) {
    incubators = Incubator.fromJson(json);
  }
}
