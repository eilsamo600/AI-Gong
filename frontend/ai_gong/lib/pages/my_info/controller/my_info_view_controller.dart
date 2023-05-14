import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:ai_gong/restAPI/models/MyInfo.dart';
import 'package:ai_gong/restAPI/response/get_classroom_list_response.dart';
import 'package:ai_gong/restAPI/response/get_classroom_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../restAPI/models/Incubator.dart';
import '../../../restAPI/response/get_my_reservation_list_response.dart';
import '../../../restAPI/response/get_my_reservation_response.dart';

class MyInfoViewController extends GetxController {
  static MyInfoViewController get instance => Get.find<MyInfoViewController>();

  Future<void> getClassRoomList() async {
    ApiResponse<ClassRoomListResponse> response =
        await ApiService.instance.getClassRoomList();
    if (response.result) {
      classRoomList.value = response.value!.classrooms!;
    }
    classRoomList.refresh();
  }

  Future<void> getClassRoom(int id) async {
    classRoom.value = ClassRoom();
    ApiResponse<ClassRoomResponse> response =
        await ApiService.instance.getClassRoom(id);
    await Future.delayed(const Duration(milliseconds: 150));
    if (response.result) {
      classRoom.value = response.value!.classroom!;
    }
  }

  // @override
  // void onInit() async {
  //   super.onInit();
  //   await getMyReservationList();
  // }

  // Future<void> getMyReservationList() async {
  //   ApiResponse<MyReservationListResponse> response = await ApiService.instance.getMyReservationList();
  //   if (response.result) {
  //     myReservationList.value = response.value!.incubators!;
  //   }
  //   myReservationList.refresh();
  // }

  //   Future<void> getMyReservation(int id) async {
  //   myReservation.value=Incubator();
  //   ApiResponse<MyReservationResponse> response = await ApiService.instance.getMyReservation();
  //   await Future.delayed(const Duration(milliseconds: 150));
  //   if(response.result){
  //     myReservation.value=response.value!.incubators!;
  //   }

  // }

  Rx<ScrollController> scrollcontroller = ScrollController().obs;

  Rx<ClassRoom> classRoom = ClassRoom().obs;
  RxList<ClassRoom> classRoomList = RxList<ClassRoom>();

  // Rx<MyInfo> myInfo=MyInfo().obs;
  // RxList<MyInfo> myInfoList = RxList<MyInfo>();
  Rx<Incubator> myReservation = Incubator().obs;
  RxList<Incubator> myReservationList = RxList<Incubator>();
}
