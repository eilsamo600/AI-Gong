import 'package:ai_gong/Service/user_service.dart';
import 'package:ai_gong/common/common.dart';
import 'package:ai_gong/common/widget/panel_component.dart';
import 'package:ai_gong/pages/list_incubator/controller/list_incubator_view_controller.dart';
import 'package:ai_gong/restAPI/models/Incubator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// ignore_for_file: prefer_const_constructors

class IncubatorComponent extends StatelessWidget {
  final Incubator model;
  const IncubatorComponent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];
    final now = DateTime.now().toUtc().add(Duration(days: 2));
    final firstTime = DateFormat('d').format(DateTime.utc(now.year, now.month, now.day - (now.weekday - 1)));
    final lastTime = DateFormat('d').format(DateTime.utc(now.year, now.month, now.day + (7 - now.weekday)));
    final monthText = DateFormat('M월').format(DateTime(now.month, 5));

    final controller = Get.put(ListIncubatorViewController());
    const textstyle = TextStyle(fontSize: 20);
    const textstyle2 = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
    List<String> weeks = ['월', '화', '수', '목', '금', '토', '일'];

    return InkWell(
      onTap: () {
        controller.statesInit();
        controller.datesInit();
        controller.numInit();
        controller.roomnumInit();
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: ((context) {
              return PanelComponent(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Row(children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text('소회의실 ${model.roomNum ?? '???'}호', style: textstyle2),
                      ]),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    SizedBox(
                        height: 55,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(monthText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2.0)),
                          ],
                        )),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 30, vertical: 15),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       for (var i = 0; i < 7; i++)
                    //         Column(
                    //           children: [
                    //             Text(
                    //               weeks[i],
                    //               style: TextStyle(
                    //                   color:
                    //                       i > 4 ? Colors.grey : Colors.black),
                    //             ),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             Text(
                    //               DateFormat('d').format(DateTime.utc(
                    //                   now.year,
                    //                   now.month,
                    //                   now.day - (now.weekday - 1) + i)),
                    //               style: TextStyle(
                    //                   color: i > 4 ? Colors.grey : Colors.black,
                    //                   decoration: i > 4
                    //                       ? TextDecoration.lineThrough
                    //                       : null),
                    //             )
                    //           ],
                    //         )
                    //     ],
                    //   ),
                    // ),

                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (var i = 0, j = int.parse(firstTime); i < 7; i++, j++)
                              InkWell(
                                onTap: () {
                                  controller.date(i.toInt(), j.toInt());
                                },
                                child: Obx(() => Container(
                                      width: 50,
                                      height: 65,
                                      decoration: BoxDecoration(
                                        border: controller.dates.value[i.toInt()] == 2
                                            ? Border.all(
                                                color: Color(0xff567BE6),
                                                width: 2.0,
                                              )
                                            // ) : Border.all(
                                            //   color: Color(0xff567BE6),
                                            //   width: 2.0,
                                            // ),
                                            : null,
                                        color: controller.dates.value[i.toInt()] == 2 ? Color(0xffEFF3FF) : null,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            weeks[i],
                                            style: TextStyle(color: i > 4 ? Colors.grey : Colors.black),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            DateFormat('d').format(DateTime.utc(now.year, now.month, now.day - (now.weekday - 1) + i)),
                                            style: TextStyle(color: i > 4 ? Colors.grey : Colors.black, decoration: i > 4 ? TextDecoration.lineThrough : null),
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: 500,
                        child: Divider(
                          color: Colors.grey,
                          height: 1,
                          thickness: 0.6,
                        )),
                    SizedBox(
                        height: 100,
                        child: Row(
                          children: const [
                            SizedBox(
                              height: 70,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '예약가능 시간',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )),
                    Center(
                      child: Wrap(
                        spacing: 50.0, // 각 버튼 사이의 가로 간격
                        runSpacing: 40.0, // 버튼 사이 세로 간격
                        children: [
                          for (double i = 9.0, j = 1.0, a = 0; i < 17.0; i += 0.5, j++, a++)
                            InkWell(
                              onTap: () {
                                controller.selected(a.toInt());
                              },
                              child: Obx(
                                () => Container(
                                  decoration: BoxDecoration(
                                      color: controller.states.value[a.toInt()] == 0
                                          ? Colors.white
                                          : controller.states.value[a.toInt()] == 2
                                              ? Colors.white
                                              : //Color(0xffEFF3FF),
                                              Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0xffDDDDDD),
                                          blurRadius: 3.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(0.0, 0.0),
                                        )
                                      ],
                                      border: controller.states.value[a.toInt()] == 1
                                          ? Border.all(
                                              color: Color(0xff567BE6),
                                              width: 2.0,
                                            )
                                          : null,
                                      borderRadius: BorderRadius.circular(5)),
                                  width: 110,
                                  height: 55,
                                  child: Center(
                                    child: Text(
                                      '${i.toInt()}:${(i % 1 == 0.5) ? "30" : "00"} ~ ${(i % 1 == 0.5) ? "${i.toInt() + 1}:00" : "${i.toInt()}:30"}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: controller.states.value[a.toInt()] == 0
                                            ? Colors.black
                                            : controller.states.value[a.toInt()] == 2
                                                ? Color(0xffDEE0E4)
                                                : Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    Padding(
                        padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // SizedBox(
                            //   width: 20,
                            // ),
                            Text(
                              '인원',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      if (controller.num.value > 0) {
                                        controller.numchange(-1);
                                      }
                                    },
                                    child: Container(
                                      height: 43,
                                      width: 43,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xffDDDDDD),
                                            blurRadius: 3.0,
                                            spreadRadius: 0.5,
                                            offset: Offset(0.0, 0.0),
                                          )
                                        ],
                                        border: Border.all(
                                          color: Color(0xffDDDDDD),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '-',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                Obx(
                                  () => Text(
                                    controller.num.value.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                    onTap: () {
                                      if (controller.num.value < 7) {
                                        controller.numchange(1);
                                      }
                                    },
                                    child: Container(
                                      height: 43,
                                      width: 43,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xffDDDDDD),
                                            blurRadius: 3.0,
                                            spreadRadius: 0.5,
                                            offset: Offset(0.0, 0.0),
                                          )
                                        ],
                                        border: Border.all(
                                          color: Color(0xffDDDDDD),
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '+',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Wrap(children: [
                        SizedBox(
                          width: 450,
                          height: 55,
                          child: OutlinedButton(
                            onPressed: () async {
                              bool islogin = await UserService.instance.isLogin();
                              if (!islogin) {
                                Common.loginPanel();
                                return;
                              }
                              controller.roomnumchange(model.roomNum!.toInt());
                              controller.postReservation(context);
                            },
                            child: Text(
                              '예약하기',
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 13),
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (model.usableLevel ?? 1) == 1
                    ? Colors.green
                    : model.usableLevel == 2
                        ? Colors.orange
                        : model.usableLevel == 4
                            ? const Color.fromARGB(255, 206, 0, 0)
                            : Colors.red,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '소회의실 ${model.roomNum ?? '???'}',
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI공학관 ${model.classNum ?? '???'}호',
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: model.usableLevel == null
                  ? const Text(
                      '다음 예약이 없습니다.',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '현재 사용중',
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'AI공학관 ${model.classNum ?? '???'}호',
                          style: const TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
