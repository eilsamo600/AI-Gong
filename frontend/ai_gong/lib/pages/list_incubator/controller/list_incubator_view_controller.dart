import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/Incubator.dart';
import 'package:ai_gong/restAPI/models/Reservation.dart';
import 'package:ai_gong/restAPI/response/get_available_reservation.dart';
import 'package:ai_gong/restAPI/response/get_incubator_list_response.dart';
import 'package:ai_gong/restAPI/response/get_incubator_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ListIncubatorViewController extends GetxController {
  static ListIncubatorViewController get instance => Get.find<ListIncubatorViewController>();

  RxList<int> dates = List.filled(7, 0).obs;
  RxList<int> states = List.filled(17, 0).obs;
  var today = DateTime.now().toUtc();

  void postReservation(BuildContext context, int? roomNum) async {
    int val = dates.value.indexOf(2);
    List<int> timeval = [];

    for (int i = 0; i < states.value.length; i++) {
      if (states.value[i] == 1) {
        timeval.add(i);
      }
    }
    String day = DateFormat('d').format(DateTime.utc(today.year, today.month, today.day - (today.weekday - 1) + val));

    var data = Reservation.fromJson({
      'email': 'thwjd082@gachon.ac.kr',
      'number': roomnum.toString(),
      'time': (timeval).cast<int>(),
      'date': (today.year.toString() + today.month.toString() + day),
      'people': num.value,
      'state': 0
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
                child: const Text(
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
                child: const Text(
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

  void statesInit(int? roomNum) async {
    states.value = List.filled(16, 0);
    int count = -2;
    int val = dates.value.indexOf(2);
    var todayIndex = today.weekday - 1;
    if (todayIndex == 5) {
      today = today.add(const Duration(days: 2)); // Add 2 days to skip the weekend
      todayIndex = today.weekday - 1;
    }
    if (todayIndex == 6) {
      today = today.add(const Duration(days: 1)); // Add 2 days to skip the weekend
      todayIndex = today.weekday - 1;
    }
    String day = DateFormat('d').format(DateTime.utc(today.year, today.month, today.day - (today.weekday - 1) + val));
    String checkday = today.year.toString() + today.month.toString() + day;
    String checknow = now.value.year.toString() + now.value.month.toString() + now.value.day.toString();
    int parsedCheckday = int.parse(checknow);
    int parsednow = int.parse(checknow);

    print("checkday:$checkday 오늘 날짜: $day");

    if (parsedCheckday > parsednow) {
      states.value = List.filled(17, 0);
      await getAvailableReservation(roomNum.toString(), checkday);
    } else if (parsedCheckday == parsednow) {
      await getAvailableReservation(roomNum.toString(), checkday);
      if (now.value.hour >= 9) {
        for (int i = 9; i <= now.value.hour; i++) {
          if (i >= 17) {
            count++;
            break;
          }
          count += 2;
        }
      }
      for (int i = 0; i <= count; i++) {
        //현재 시각까지 안눌리게
        states.value[i] = 2;
      }
      if (now.value.hour < 17) {
        //30분이 넘었다면 앞타임도 안눌리게
        if (now.value.minute >= 30) {
          states.value[++count] = 2;
        }
      }
    } else {
      states.value = List.filled(17, 2);
    }
    states.refresh();
  }

  void selected(int index) {
    int start = states.value.indexOf(1);
    int end = 0;
    // 0이 안눌림, 1이 눌림, 2는 안됨
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
      for (int i = index; i < (start + 4 > 15 ? 16 : start + 4); i++) {
        if (states.value[i] != 2) {
          states.value[i] = 0;
        }
      }
      if (!states.value.contains(1)) {
        for (int i = 0; i < states.length; i++) {
          if (states.value[i] != 2) {
            states.value[i] = 0;
          }
        }
      }
    }

    states.refresh();
  }

  void datesInit() {
    var todayIndex = today.weekday - 1;
    if (todayIndex == 5) {
      today = today.add(const Duration(days: 2)); // Add 2 days to skip the weekend
      todayIndex = today.weekday - 1;
    }
    if (todayIndex == 6) {
      today = today.add(const Duration(days: 1)); // Add 2 days to skip the weekend
      todayIndex = today.weekday - 1;
    }
    dates.value = List.filled(7, 0);
    for (int i = 0; i < 7; i++) {
      if (i == todayIndex) {
        dates.value[i] = 2; // 오늘 날짜를 강조함
      } else if (i == 5 || i == 6) {
        dates.value[i] = 0; // 주말은 선택 불가능하도록 함
      } else if (i < todayIndex) {
        dates.value[i] = 0; //지난 날짜는 선택 불가능하도록 함
      } else {
        dates.value[i] = 1; // 평일은 선택 가능하도록 함
      }
    }
    dates.refresh();
  }

  void date(int d, int today, int? roomNum) {
    if (d == 5 || d == 6) {
      //토요일, 일요일은 안눌리게끔
      dates.value[d] = 0;
    } else {
      //평일일 경우
      dates.value[d] = 2;
      for (int i = 0; i < 7; i++) {
        if (i != d && dates.value[i] == 2) {
          dates.value[i] = 1;
          statesInit(roomNum);
          numInit();
        }
      }
    }

    dates.refresh();
  }

  Rx<int> num = 0.obs;
  Rx<int> roomnum = 0.obs;

  void numInit() {
    num.value = 0;
    num.refresh();
  }

  void roomnumInit() {
    roomnum.value = 0;
    roomnum.refresh();
  }

  void roomnumchange(int n) {
    roomnum.value += n;
    roomnum.refresh();
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
    ApiResponse<IncubatorListResponse> response = await ApiService.instance.getIncubatorList();
    if (response.result) {
      incubatorList.value = response.value!.incubators!;
    }
    incubatorList.refresh();
  }

  Future<void> getIncubator(int id) async {
    incubator.value = Incubator();
    ApiResponse<IncubatorResponse> response = await ApiService.instance.getIncubator(id);
    await Future.delayed(const Duration(milliseconds: 150));
    if (response.result) {
      incubator.value = response.value!.incubator!;
    }
  }

  Future<void> getAvailableReservation(String number, String date) async {
    List<int> timelist = [];

    ApiResponse<AvailableReservationResponse> responseresult = await ApiService.instance.getAvailableReservation(number, date);

    print(responseresult.value.toString());
    if (responseresult.result != null) {
      print('1');
      reservations.value = responseresult.value!.reservations!;
      print('2');
      for (var i in reservations) {
        print("true");
        if (i.time != null) {
          print(i.time);
          for (var time in i.time!) {
            for (var time in timelist) {
              print(time);
              states.value[time] = 2;
            }
          }
        }
      }
      print("finish");
    } else if (responseresult.value == null) {
      states.value = List.filled(16, 0);
    }
    for (int i = 0; i < timelist.length; i++) {
      int val = timelist[i];
      print(val);
      states.value[val] = 2;
    }
    states.refresh();
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
  Rx<Reservation> reservation = Reservation().obs;
  RxList<Reservation> reservations = RxList<Reservation>();
}
