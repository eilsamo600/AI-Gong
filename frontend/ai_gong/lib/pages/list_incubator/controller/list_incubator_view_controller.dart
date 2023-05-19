import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/Incubator.dart';
import 'package:ai_gong/restAPI/response/get_incubator_list_response.dart';
import 'package:ai_gong/restAPI/response/get_incubator_response.dart';
import 'package:ai_gong/restAPI/models/Reservation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListIncubatorViewController extends GetxController {
  static ListIncubatorViewController get instance =>
      Get.find<ListIncubatorViewController>();

  RxList<int> states = List.filled(17, 0).obs;
  final today = DateTime.now().toUtc();

  void postReservation(BuildContext context) async {
    int val = dates.value.indexOf(1);
    int timeval = states.value.indexOf(1);
    String day = DateFormat('d').format(DateTime.utc(
        today.year, today.month, today.day - (today.weekday - 1) + val));
    var data = Reservation.fromJson({
      'email': 'thwjd082@gachon.ac.kr',
      'number': "1",
      'time': (timeval as List).cast<int>(),
      'date': (today.year.toString()) +
          (today.month.toString()) +
          (today.day.toString()),
      'people': (num.value as int)
    });

    ApiResponse response = await ApiService.instance.postReservation(data);

    if (response.result == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  height: 20,
                ),
                Text(
                  '예약이 완료 되었습니다.',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 8),
                Text('예약시간까지 배정인증을 해주세요.', style: TextStyle(fontSize: 15)),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Get.back();
                  Get.back();
                },
              ),
            ],
          );
        },
      );
    } else if (response.result == false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  height: 20,
                ),
                Text('예약실패'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Get.back();
                  Get.back();
                },
              ),
            ],
          );
        },
      );
    }
  }

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

  RxList<int> dates = List.filled(7, 0).obs;

  void datesInit() {
    var todayIndex = today.weekday - 1;
    if (todayIndex == 5 || todayIndex == 6) {
      todayIndex = 0;
    }
    dates.value = List.filled(7, 0);
    for (int i = 0; i < 7; i++) {
      if (i == todayIndex) {
        dates.value[i] = 2; // 오늘 날짜를 강조함
      } else if (i == 5 || i == 6) {
        dates.value[i] = 0; // 주말은 선택 불가능하도록 함
      } else {
        dates.value[i] = 1; // 평일은 선택 가능하도록 함
      }
    }
    dates.refresh();
  }

  void date(int d, int today) {
    if (d == 5 || d == 6) {
      //토요일, 일요일은 안눌리게끔
      dates.value[d] = 0;
    } else {
      //평일일 경우
      dates.value[d] = 2;
      for (int i = 0; i < 7; i++) {
        if (i != d && dates.value[i] == 2) {
          dates.value[i] = 0;
          statesInit();
          numInit();
        }
      }
    }

    dates.refresh();
  }

  Rx<int> num = 0.obs;

  void numInit() {
    num.value = 0;
    num.refresh();
  }

  void numchange(int n) {
    num.value += n;
    num.refresh();
  }

  @override
  void onInit() async {
    super.onInit();
    await getIncubatorList();
    now.value = DateTime.now();
    await Future.delayed(Duration(seconds: 60 - now.value.second), () {
      now.value = DateTime.now();
    });
    checkTimer();
  }

  Future<void> getIncubatorList() async {
    ApiResponse<IncubatorListResponse> response =
        await ApiService.instance.getIncubatorList();
    if (response.result) {
      incubatorList.value = response.value!.incubators!;
    }
    incubatorList.refresh();
  }

  Future<void> getIncubator(int id) async {
    incubator.value = Incubator();
    ApiResponse<IncubatorResponse> response =
        await ApiService.instance.getIncubator(id);
    await Future.delayed(const Duration(milliseconds: 150));
    if (response.result) {
      incubator.value = response.value!.incubator!;
    }
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
  Rx<Incubator> incubator = Incubator().obs;
  RxList<Incubator> incubatorList = RxList<Incubator>();
}
