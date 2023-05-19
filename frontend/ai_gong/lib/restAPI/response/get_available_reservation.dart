import 'package:ai_gong/restAPI/models/Reservation.dart';

class AvailableReservationResponse {
  List<Reservation>? reservation;

  AvailableReservationResponse({this.reservation});

  AvailableReservationResponse.fromJson(List<dynamic> jsonList) {
    if (jsonList.isNotEmpty) {
      reservation = <Reservation>[];
      for (var v in jsonList) {
        reservation!.add(Reservation.fromJson(v));
      }
    }
  }
}
