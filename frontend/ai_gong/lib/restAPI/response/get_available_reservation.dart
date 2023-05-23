import 'package:ai_gong/restAPI/models/Reservation.dart';

class AvailableReservationResponse {
  List<Reservation>? reservations;

  AvailableReservationResponse({this.reservations});

  AvailableReservationResponse.fromJson(List<dynamic> jsonlist) {
    if (jsonlist.isNotEmpty) {
      reservations = <Reservation>[];
      for (var v in jsonlist) {
        print(v);
        reservations!.add(Reservation.fromJson(v));
      }
    } else {
      print("jsonlist 빔");
    }
  }
}
