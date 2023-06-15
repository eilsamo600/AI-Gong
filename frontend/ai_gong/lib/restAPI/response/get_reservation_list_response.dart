import '../models/Reservation.dart';

// Summary:
// ReservationListResponse is used to parse the response from the server
// This class is used in the controller
class ReservationListResponse {
  List<Reservation>? reservations;

  ReservationListResponse({this.reservations});

  ReservationListResponse.fromJson(List<dynamic> jsonList) {
    reservations = <Reservation>[];
    if (jsonList.isNotEmpty) {
      for (var v in jsonList) {
        reservations!.add(Reservation.fromJson(v));
      }
    }
  }
}
