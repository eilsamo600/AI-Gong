import 'package:ai_gong/common/widget/panel_component.dart';
import 'package:ai_gong/pages/list_incubator/controller/list_incubator_view_controller.dart';
import 'package:ai_gong/pages/list_incubator/view/list_incubator_view_page.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// ignore_for_file: prefer_const_constructors

class IncubatorComponent extends StatelessWidget {
  final ClassRoom model;
  const IncubatorComponent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];
    final now = DateTime.now().toUtc();
    final firstTime = DateFormat('d')
        .format(DateTime.utc(now.year, now.month, now.day - (now.weekday - 1)));
    final lastTime = DateFormat('d')
        .format(DateTime.utc(now.year, now.month, now.day + (7 - now.weekday)));
    final monthText = DateFormat('M월').format(DateTime(now.month, 5));

    final controller = Get.put(ListIncubatorViewController());
    const textstyle = TextStyle(fontSize: 20);
    const textstyle2 = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
    List<String> weeks = ['월', '화', '수', '목', '금', '토', '일'];

    return InkWell(
      onTap: () {
        controller.statesInit();
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
                      child: Row(children: const [
                        SizedBox(
                          width: 15,
                        ),
                        Text('소회의실 1', style: textstyle2),
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
                            Text(monthText,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0)),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var i = 0; i < 7; i++)
                            Column(
                              children: [
                                Text(
                                  weeks[i],
                                  style: TextStyle(
                                      color:
                                          i > 4 ? Colors.grey : Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  DateFormat('d').format(DateTime.utc(
                                      now.year,
                                      now.month,
                                      now.day - (now.weekday - 1) + i)),
                                  style: TextStyle(
                                      color: i > 4 ? Colors.grey : Colors.black,
                                      decoration: i > 4
                                          ? TextDecoration.lineThrough
                                          : null),
                                )
                              ],
                            )
                        ],
                      ),
                    ),
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
                          for (double i = 9.0, j = 1.0, a = 0;
                              i < 17.0;
                              i += 0.5, j++, a++)
                            InkWell(
                              onTap: () {
                                controller.selected(a.toInt());
                              },
                              child: Obx(
                                () => Container(
                                  decoration: BoxDecoration(
                                      color:
                                          controller.states.value[a.toInt()] ==
                                                  0
                                              ? Colors.white
                                              : controller.states
                                                          .value[a.toInt()] ==
                                                      2
                                                  ? Colors.grey.shade900
                                                  : Colors.grey[300],
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0xffDDDDDD),
                                          blurRadius: 3.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(0.0, 0.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(2.5)),
                                  width: 110,
                                  height: 55,
                                  child: Center(
                                    child: Text(
                                      '${i.toInt()}:${(i % 1 == 0.5) ? "30" : "00"} ~ ${(i % 1 == 0.5) ? "${i.toInt() + 1}:00" : "${i.toInt()}:30"}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
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
                    SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              '인원',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 230,
                            ),
                            CounterWidget(),
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
                            onPressed: () {
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
                                        Text('예약시간까지 배정인증을 해주세요.',
                                            style: TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          '확인',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListIncubatorViewPage()),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              '예약하기',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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
                  '소회의실 1',
                  //'소회의실 ${model.roomid ?? '???'}',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
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
                        'AI공학관 ${model.roomid ?? '???'}호',
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
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
              child: model.currentLecture == null
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
                          model.currentLecture!['시간'] ?? '???',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black87),
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

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter == 0) {
      setState(() {
        _counter = 0;
      });
    }
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 60,
          height: 40,
          child: ElevatedButton(
            onPressed: _decrementCounter,
            child: Text(
              '-',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Text(
          '$_counter',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: 60,
          height: 40,
          child: ElevatedButton(
            onPressed: _incrementCounter,
            child: Text(
              '+',
              style: TextStyle(color: Colors.black, fontSize: 23),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
