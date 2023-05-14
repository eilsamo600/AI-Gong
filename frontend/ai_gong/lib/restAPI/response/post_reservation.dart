import 'package:ai_gong/restAPI/models/Reservation.dart';

class Reservationresponse {
  List<Reservation>? reservation;

  Reservationresponse.fromJson(List<dynamic> jsonList) {
    if (jsonList.isNotEmpty) {
      reservation = <Reservation>[];
      reservation!.add(Reservation());
    }
  }
}
