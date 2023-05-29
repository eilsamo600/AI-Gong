import 'package:ai_gong/pages/my_info/controller/my_info_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../restAPI/models/Reservation.dart';

class MyInfoComponent extends StatelessWidget {
  final Reservation model;
  const MyInfoComponent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    // 20230503 을 2023.05.03으로 변경
    String roomid = "알 수 없음";
    if (int.parse(model.number ?? '0') <= 3) {
      roomid = "AI 공학관 403호";
    } else if (int.parse(model.number ?? '0') <= 6) {
      roomid = "AI 공학관 404호";
    }
    int starttime = 540;
    int endtime = 570;

    starttime += (model.time ?? [0]).first * 30;
    endtime += (model.time ?? [0]).last * 30;
    // 분을 시간으로 변경
    String startHour = (starttime / 60).round().toString();
    String endHour = (endtime / 60).round().toString();
    String start = startHour + ((starttime.remainder(60))).toString().padLeft(2, '0');
    String end = endHour + ((endtime.remainder(60))).toString().padLeft(2, '0');
    start = start.padLeft(4, '0');
    end = end.padLeft(4, '0');
    start = "${start.substring(0, 2)}:${start.substring(2, 4)}";
    end = "${end.substring(0, 2)}:${end.substring(2, 4)}";

    final controller = Get.put(MyInfoViewController());
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, //하나는 왼쪽 정렬, 하나는 오른쪽 정렬하게 만들어줌
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("소회의실 ${model.number}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(
                        //"AI공학관 ${model.roomid ?? '???'}호",
                        roomid,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                          // "2023.05.03 16:57",
                          // 20230503 을 2023.05.03으로 변경
                          "${model.date!.substring(0, 4)}.${model.date!.substring(4, 6)}.${model.date!.substring(6, 8)} - $start ~ $end",
                          style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 140, 140, 140))),
                      const SizedBox(height: 3),
                      // const Text("2023.05.03 16:57",
                      //     style: TextStyle(
                      //         fontSize: 14,
                      //         color: Color.fromARGB(255, 140, 140, 140))),
                    ],
                  ),
                ),
                // if (model.usableLevel == 2)
                //   Container(
                //       alignment: Alignment.centerRight,
                //       child: Row(
                //         children: const [
                //           SizedBox(height: 3),
                //           Text("배정인증 완료",
                //               style: TextStyle(
                //                   fontSize: 12.5,
                //                   color: Color.fromARGB(255, 0, 140, 255))),
                //           SizedBox(width: 3),
                //           Icon(Icons.check_circle_outline,
                //               color: Color.fromARGB(255, 0, 140,
                //                   255)), //Icon(Icons.check_circle_outline_rounded),
                //         ],
                //       )),
                // const Spacer(),
                // if (model.usableLevel == 1)
                //   Container(
                //       //alignment: Alignment.centerRight,
                //       child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       Row(
                //         //mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           const SizedBox(height: 3),
                //           const Text("배정인증하기",
                //               style: TextStyle(
                //                   fontSize: 12.5,
                //                   color: Color.fromARGB(255, 0, 140, 255))),
                //           //SizedBox(width: 2),
                //           InkWell(
                //             onTap: () {
                //               // 클릭 이벤트
                //             },
                //             child: const Padding(
                //               padding: EdgeInsets.all(0.0),
                //               child: Icon(Icons.chevron_right_sharp,
                //                   color: Color.fromARGB(255, 0, 140, 255)),
                //             ),
                //           )
                //         ],
                //       ),
                //       const SizedBox(height: 10),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           const SizedBox(height: 3),
                //           const Text("취소하기",
                //               style: TextStyle(
                //                   fontSize: 12.5,
                //                   color: Color.fromARGB(255, 0, 140, 255))),
                //           // SizedBox(width: 2),
                //           // Icon(Icons.chevron_right_sharp,
                //           //     color: Color.fromARGB(
                //           //         255, 0, 140, 255)),
                //           InkWell(
                //             onTap: () {
                //               // 클릭 이벤트
                //             },
                //             child: const Padding(
                //               padding: EdgeInsets.all(0.0),
                //               child: Icon(Icons.chevron_right_sharp,
                //                   color: Color.fromARGB(255, 0, 140, 255)),
                //             ),
                //           )
                //         ],
                //       ),
                //     ],
                //   )),
                // if (model.usableLevel == 3)
                //   Container(
                //       alignment: Alignment.centerRight,
                //       child: Row(
                //         // crossAxisAlignment: CrossAxisAlignment.start,
                //         children: const [
                //           SizedBox(height: 3),
                //           Text("취소되었습니다.",
                //               style: TextStyle(
                //                   fontSize: 12.5,
                //                   color: Color.fromARGB(255, 255, 44, 44))),
                //           SizedBox(width: 3),
                //           //Icon(Icons.check_circle_outline_rounded),
                //         ],
                //       )),
                // Container(
                //     height: 2, color: const Color.fromARGB(255, 228, 228, 228)),
              ],
            ),
          ),
        ],
      ),
    );
    //   ],
    // );
  }
}
