import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:ai_gong/restAPI/response/get_classroom_list_response.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ListClassRoomViewController extends GetxController {
  static ListClassRoomViewController get instance => Get.find<ListClassRoomViewController>();

  @override
  void onInit() async {
    super.onInit();
    ApiResponse<ClassRoomListResponse> response = await ApiService.instance.getClassRoomList();
    if (response.result) {
      classRoomList.value = response.value!.classrooms!;
    }
    classRoomList.refresh();
    compute(checkTimer, null);
  }

  void selectFilter(int index) {
    onTapList.value[index] = !onTapList.value[index];
    onTapList.refresh();
  }

  void checkTimer(void _) async {
    while (true) {
      await Future.delayed(const Duration(seconds: 30), () {
        now.value = DateTime.now();
        print(now.value);
      });
    }
  }

  Rx<DateTime> now = DateTime.now().obs;

  RxList<ClassRoom> classRoomList = RxList<ClassRoom>();
  RxList<bool> onTapList = List.filled(3, false).obs;
}
