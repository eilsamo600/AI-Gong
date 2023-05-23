import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:ai_gong/restAPI/response/get_classroom_list_response.dart';
import 'package:ai_gong/restAPI/response/get_classroom_response.dart';
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

  Future<void> getClassRoom(int id) async {
    lectures.value = -1;
    ApiResponse<ClassRoomResponse> response = await ApiService.instance.getClassRoom(id);
    await Future.delayed(const Duration(milliseconds: 250));
    if (response.result) {
      classRoom.value = response.value!.classroom!;
      classRoom.refresh();
      response.value!.classroom!.lectures!.forEach((key, value) {
        print(key);
        print(value);
        for (var element in value) {
          lectures.value++;
        }
      });
    } else {
      lectures.value = 0;
    }
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

  void checkbookmark() {
    if (bookmark.value == 1) {
      bookmark.value = 0;
    } else {
      bookmark.value = 1;
    }
    bookmark.refresh();
  }

  void bookmarkInit() {
    bookmark.value = 0;
  }

  Rx<ScrollController> scrollcontroller = ScrollController().obs;
  Rx<DateTime> now = DateTime.now().obs;

  Rx<ClassRoom> classRoom = ClassRoom().obs;
  RxInt lectures = (-1).obs;
  RxList<ClassRoom> classRoomList = RxList<ClassRoom>();
  RxList<bool> onTapList = List.filled(4, false).obs;
  RxList<String> filterList = ['새로고침', '즐겨찾기', '바로', '곧 끝나는'].obs;
  RxInt bookmark = 0.obs;
}
