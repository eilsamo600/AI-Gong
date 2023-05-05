import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:ai_gong/restAPI/response/get_classroom_list_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListClassRoomViewController extends GetxController {
  static ListClassRoomViewController get instance => Get.find<ListClassRoomViewController>();

  @override
  void onInit() async {
    super.onInit();
    await getClassRoomList();
    now.value = DateTime.now();
    await Future.delayed(Duration(seconds: 60 - now.value.second), () {
      now.value = DateTime.now();
    });
    checkTimer();
  }

  Future<void> getClassRoomList() async {
    ApiResponse<ClassRoomListResponse> response = await ApiService.instance.getClassRoomList();
    if (response.result) {
      classRoomList.value = response.value!.classrooms!;
    }
    classRoomList.refresh();
  }

  void selectFilter(int index) {
    index = index;
    onTapList.value[index] = !onTapList.value[index];
    onTapList.refresh();
  }

  void restFilter() {
    for (var i = 0; i < onTapList.length; i++) {
      onTapList[i] = false;
    }
    onTapList.refresh();
  }

  void checkTimer() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 60), () {
        now.value = DateTime.now();
      });
    }
  }

  Rx<ScrollController> scrollcontroller = ScrollController().obs;
  Rx<DateTime> now = DateTime.now().obs;

  RxList<ClassRoom> classRoomList = RxList<ClassRoom>();
  RxList<bool> onTapList = List.filled(4, false).obs;
  RxList<String> filterList = ['새로고침', '즐겨찾기', '바로', '곧 끝나는'].obs;
}
