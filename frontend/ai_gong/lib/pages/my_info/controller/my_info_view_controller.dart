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
    }
    myReservationList.refresh();
  }

  RxList<Reservation> myReservationList = RxList<Reservation>();
}
