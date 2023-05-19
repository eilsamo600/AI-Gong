import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:ai_gong/restAPI/models/Reservation.dart';
import 'package:ai_gong/restAPI/response/get_classroom_list_response.dart';
import 'package:ai_gong/restAPI/response/get_classroom_response.dart';
import 'package:get/get.dart';

import '../../../restAPI/models/Incubator.dart';
import '../../../restAPI/response/get_reservation_list_response.dart';
import '../../../restAPI/response/post_reservation.dart';

class MyInfoViewController extends GetxController {
  static MyInfoViewController get instance => Get.find<MyInfoViewController>();

  // Future<void> getClassRoomList() async {
  //   ApiResponse<ClassRoomListResponse> response =
  //       await ApiService.instance.getClassRoomList();
  //   if (response.result) {
  //     classRoomList.value = response.value!.classrooms!;
  //   }
  //   classRoomList.refresh();
  // }

  // Future<void> getClassRoom(int id) async {
  //   classRoom.value = ClassRoom();
  //   ApiResponse<ClassRoomResponse> response =
  //       await ApiService.instance.getClassRoom(id);
  //   await Future.delayed(const Duration(milliseconds: 150));
  //   if (response.result) {
  //     classRoom.value = response.value!.classroom!;
  //   }
  // }

  @override
  void onInit() async {
    super.onInit();
    // await getClassRoomList();
    await getMyReservationList();
  }

  Future<void> getMyReservationList() async {
    ApiResponse<ReservationListResponse> response =
        await ApiService.instance.getReservationList();
    if (response.result) {
      myReservationList.value = response.value!.reservations!;
    }
    myReservationList.refresh();
  }

  //   Future<void> getMyReservation(int id) async {
  //   myReservation.value=Reservation();
  //   ApiResponse<Reservationresponse> response = await ApiService.instance.getReservation();
  //   await Future.delayed(const Duration(milliseconds: 150));
  //   if(response.result){
  //     myReservation.value=response.value!.reservation!;
  //   }

  // }

  // Rx<ClassRoom> classRoom = ClassRoom().obs;
  // RxList<ClassRoom> classRoomList = RxList<ClassRoom>();

  // Rx<MyInfo> myInfo=MyInfo().obs;
  // RxList<MyInfo> myInfoList = RxList<MyInfo>();
  Rx<Reservation> myReservation = Reservation().obs;
  RxList<Reservation> myReservationList = RxList<Reservation>();
}
