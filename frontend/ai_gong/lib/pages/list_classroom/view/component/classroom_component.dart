import 'package:ai_gong/common/widget/panel_component.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:flutter/material.dart';

class ClassRoomComponent extends StatelessWidget {
  final ClassRoom model;
  const ClassRoomComponent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: ((context) {
              return PanelComponent(
                  child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 370, 0),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.roomid ?? '???'}호',
                          style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 370, 0),
                    child: const Text(
                      "현재 강의",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    height: 1,
                    padding: const EdgeInsets.fromLTRB(0, 0, 370, 0),
                    child: const SizedBox(
                      width: 60,
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            model.currentLecture == null
                                ? const Text(
                                    '다음 수업이 없습니다.',
                                    style: TextStyle(fontSize: 12, color: Colors.black87),
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.currentLecture!['이름'] ?? '???',
                                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${model.currentLecture!['담당교수'] ?? '???'} 교수',
                                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        model.currentLecture!['시간'] ?? '???',
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.only(right: 30),
                              child: Text(
                                  (model.usableLevel ?? 1) == 1
                                      ? '사용 가능'
                                      : model.usableLevel == 2
                                          ? '곧 사용 가능'
                                          : model.usableLevel == 4
                                              ? '곧 수업 시작'
                                              : '사용 불가',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: (model.usableLevel ?? 1) == 1
                                        ? Colors.green
                                        : model.usableLevel == 2
                                            ? Colors.orange
                                            : model.usableLevel == 4
                                                ? const Color.fromARGB(255, 206, 0, 0)
                                                : Colors.red,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ));
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
                  '${model.roomid ?? '???'}호',
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
                        model.department ?? '???전공',
                        style: const TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        '${model.floor ?? '???'}층, 수용 인원 ${model.capacity ?? '???'}명',
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Text(
                            '${model.scale ?? '???'} 강의실 | ',
                            style: const TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                          Text(
                              (model.usableLevel ?? 1) == 1
                                  ? '사용 가능'
                                  : model.usableLevel == 2
                                      ? '곧 사용 가능'
                                      : model.usableLevel == 4
                                          ? '곧 수업 시작'
                                          : '사용 불가',
                              style: const TextStyle(fontSize: 12, color: Colors.black)),
                        ],
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
                      '다음 수업이 없습니다.',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          model.currentLecture!['이름'] ?? '???',
                          style: const TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${model.currentLecture!['담당교수'] ?? '???'} 교수',
                          style: const TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          model.currentLecture!['시간'] ?? '???',
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
