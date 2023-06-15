import 'package:ai_gong/restAPI/models/Reservation.dart';

// Summary:
// Reservationresponse is used to parse the response from the server
// This class is used in the controller
class Reservationresponse {
  List<Reservation>? reservation;

  Reservationresponse.fromJson(List<dynamic> jsonList) {
    if (jsonList.isNotEmpty) {
      reservation = <Reservation>[];
      reservation!.add(Reservation());
    }
  }
}
