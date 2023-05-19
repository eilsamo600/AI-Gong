import 'package:ai_gong/restAPI/models/Reservation.dart';

class AvailableReservationResponse {
  Reservation? reservation;

  AvailableReservationResponse({this.reservation});

  AvailableReservationResponse.fromJson(Map<String, dynamic> json) {
    reservation = Reservation.fromJson(json);
  }
}
