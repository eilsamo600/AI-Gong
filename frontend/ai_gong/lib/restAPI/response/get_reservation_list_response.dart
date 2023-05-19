import '../models/Reservation.dart';

class ReservationListResponse {
  List<Reservation>? reservations;

  ReservationListResponse({this.reservations});

  ReservationListResponse.fromJson(List<dynamic> jsonList) {
    if (jsonList.isNotEmpty) {
      reservations = <Reservation>[];
      for (var v in jsonList) {
        reservations!.add(Reservation.fromJson(v));
      }
    }
  }
}
