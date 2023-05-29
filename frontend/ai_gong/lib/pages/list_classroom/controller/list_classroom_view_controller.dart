import 'package:ai_gong/Service/user_service.dart';
import 'package:ai_gong/common/common.dart';
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
    ApiResponse<ClassRoomListResponse> response;
    if (onTapList.value[1]) {
      response = await ApiService.instance.getClassRoomListByLike();
    } else {
      response = await ApiService.instance.getClassRoomList();
    }
    if (response.result) {
      classRoomList.value = response.value!.classrooms!;
      classRoomList.value = classRoomList.value
          .where((classRoom) =>
              (classRoom.usableLevel == 1 && onTapList.value[2]) ||
              (classRoom.usableLevel == 2 && onTapList.value[3]) ||
              (!onTapList.value[2] && !onTapList.value[3]))
          .toList();
    }
    classRoomList.refresh();
  }

  Future<void> getClassRoom(String id) async {
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

  Future<void> postLikeClassRoom(String id) async {
    ApiResponse<ClassRoomResponse> response = await ApiService.instance.postLikeAndClassroom(id);
    await Future.delayed(const Duration(milliseconds: 250));
    if (response.result) {
      classRoom.value.isLike = response.value!.classroom!.isLike;
      classRoom.refresh();
    } else {}
  }

  void selectFilter(int index) {
    scrollcontroller.value.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
    if (index == 0) {
      restFilter();
      getClassRoomList();
      return;
    }
    if (index == 1 && UserService.instance.logining == false) {
      Common.loginPanel();
      return;
    }

    onTapList.value[index] = !onTapList.value[index];
    if (index == 2) {
      onTapList.value[3] = false;
    } else if (index == 3) {
      onTapList.value[2] = false;
    }
    getClassRoomList();
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

  Rx<ClassRoom> classRoom = ClassRoom().obs;
  RxInt lectures = (-1).obs;
  RxList<ClassRoom> classRoomList = RxList<ClassRoom>();
  RxList<bool> onTapList = List.filled(4, false).obs;
  RxList<String> filterList = ['새로고침', '즐겨찾기', '바로', '곧 끝나는'].obs;
}
