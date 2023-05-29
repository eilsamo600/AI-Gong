import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/Reservation.dart';
import 'package:get/get.dart';

import '../../../restAPI/response/get_reservation_list_response.dart';

class MyInfoViewController extends GetxController {
  static MyInfoViewController get instance => Get.find<MyInfoViewController>();

  Future<void> getMyReservationList() async {
    ApiResponse<ReservationListResponse> response = await ApiService.instance.getReservationList();
    if (response.result) {
      myReservationList.value = response.value!.reservations!;
      // sorting by id desc
      myReservationList.value.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    }
    myReservationList.refresh();
  }

  Future<void> postReservationState(String id, int state) async {
    ApiResponse response = await ApiService.instance.postReservationState(id, state);
    if (response.result) {
      await getMyReservationList();
    }
  }

  Future<void> deleteReservation(String id) async {
    ApiResponse response = await ApiService.instance.deleteReservation(id);
    if (response.result) {
      await getMyReservationList();
    }
  }

  RxList<Reservation> myReservationList = RxList<Reservation>();
}
