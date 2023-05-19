import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:flutter/material.dart';

import '../../../../restAPI/models/Reservation.dart';

class MyInfoComponent extends StatelessWidget {
  final Reservation model;
  const MyInfoComponent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, //하나는 왼쪽 정렬, 하나는 오른쪽 정렬하게 만들어줌
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("소회의실 ${model.number ?? '???'}",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 3),
                      Text(
                        //"AI공학관 ${model.roomid ?? '???'}호",
                        "인원수: ${model.people ?? '???'}",
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                          // "2023.05.03 16:57",
                          "${model.date} ${model.time}",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 140, 140, 140))),
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
