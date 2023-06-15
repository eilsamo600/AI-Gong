import 'package:ai_gong/restAPI/models/Reservation.dart';

// Summary:
// AvailableReservationResponse is used to parse the response from the server
// This class is used in the controller
class AvailableReservationResponse {
  List<Reservation>? reservations;

  AvailableReservationResponse({this.reservations});

  AvailableReservationResponse.fromJson(List<dynamic> jsonlist) {
    if (jsonlist.isNotEmpty) {
      print("jsonlist 안빔");
      reservations = <Reservation>[];
      for (var v in jsonlist) {
        print(v);
        reservations!.add(Reservation.fromJson(v));
        print(reservations);
      }
    } else {
      print("jsonlist 빔");
      reservations = [];
    }
  }
}
