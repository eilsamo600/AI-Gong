import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:ai_gong/restAPI/response/get_classroom_list_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListIncubatorViewController extends GetxController {
  static ListIncubatorViewController get instance => Get.find<ListIncubatorViewController>();

  RxList<int> states = List.filled(17, 0).obs;

  void statesInit() {
    states.value = List.filled(16, 0);
    states.refresh();
  }

  void selected(int index) {
    int start = states.value.indexOf(1);
    int end = 0;
    if (states.value[index] == 0) {
      if (start == -1) {
        // 아무것도 안 눌림
        states.value[index] = 1;

        for (int i = index + 4; i < states.length; i++) {
          if (i < states.length) {
            states.value[i] = 2;
          }
        }
        for (int i = index - 1; i >= 0; i--) {
          states.value[i] = 2;
        }
      } else {
        // 무언가 눌림
        for (int i = start; i < index + 1; i++) {
          states.value[i] = 1;
        }
      }
    } else if (states.value[index] == 1) {
      for (int i = index; i < start + 4; i++) {
        states.value[i] = 0;
      }
      if (!states.value.contains(1)) {
        for (int i = 0; i < states.length; i++) {
          states.value[i] = 0;
        }
      }
      // states.value.
      // if (!states.value.contains(1)) {
      //   for (int i = 0; i < states.length; i++) {
      //     states.value[i] = 0;
      //   }
      // }
    }
    // 취소
    // if (states.value[index] == 1) {
    //   states.value[index] = 0;
    // } else if (states.value[index] == 0) {
    //   states.value[index] = 1;
    // }

    // if (states.value[index] == 1) {
    //   states.value[index] = 0;
    //   int start = states.value.indexOf(1);
    //   // 선택한 애 앞에 3개는 다 흰색
    //   if (start != 0) {
    //     for (int i = start + 1; i < (start + 4 > states.length ? states.length : start + 4); i++) {
    //       if (start < index + 4) {
    //         if (states.value[i] != 1) {
    //           states.value[i] = 0;
    //         }
    //       }
    //     }
    //     for (int i = start - 1; i >= 0; i--) {
    //       states.value[i] = 2;
    //     }
    //   }
    //   start = states.value.indexOf(1);
    //   if (start == -1) {
    //     for (int i = 0; i < states.length; i++) {
    //       states.value[i] = 0;
    //     }
    //   }
    //   start = states.value.indexOf(1);
    //   for (int i = index + 1; i < (index + 3 > states.length ? states.length : index + 3); i++) {
    //     if (states.value[i] == 1) {
    //       states.value[i] = 0;
    //     }
    //   }
    // } else if (states.value[index] == 0) {
    //   // 선택
    //   states.value[index] = 1;
    //   // 무조건 내뒤는 다 검정색
    //   int start = states.value.indexOf(1);
    //   if (start != 0) {
    //     for (int i = start - 1; i >= 0; i--) {
    //       states.value[i] = 2;
    //     }
    //   }

    //   // 선택한 애 앞에 다 검정색
    //   for (int i = index + 4; i < states.length; i++) {
    //     states.value[i] = 2;
    //   }
    // }

    states.refresh();
  }

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
      await Future.delayed(const Duration(minutes: 60), () {
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
