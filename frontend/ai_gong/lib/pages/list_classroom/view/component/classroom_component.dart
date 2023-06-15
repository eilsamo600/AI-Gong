import 'package:ai_gong/Service/user_service.dart';
import 'package:ai_gong/common/widget/TimeTable.dart';
import 'package:ai_gong/common/widget/panel_component.dart';
import 'package:ai_gong/pages/list_classroom/controller/list_classroom_view_controller.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassRoomComponent extends StatelessWidget {
  final ClassRoom model;
  const ClassRoomComponent({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ListClassRoomViewController());
    return InkWell(
      onTap: () {
        controller.classRoom.value.isLike = null;
        ListClassRoomViewController.instance.getClassRoom(model.roomid!);
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: ((context) {
              return PanelComponent(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${model.roomid ?? '???'}호',
                          style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Container(
                            padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                            child: Obx(() => controller.classRoom.value.isLike == null || UserService.instance.logining == false
                                ? const SizedBox()
                                : controller.classRoom.value.isLike == true
                                    ? IconButton(
                                        icon: const Icon(Icons.bookmark),
                                        color: Colors.blue,
                                        iconSize: 27,
                                        onPressed: () async {
                                          await controller.postLikeClassRoom(model.roomid!);
                                        })
                                    : IconButton(
                                        icon: const Icon(Icons.bookmark_border),
                                        iconSize: 27,
                                        onPressed: () async {
                                          await controller.postLikeClassRoom(model.roomid!);
                                        },
                                      ))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Container(
                    margin: const EdgeInsets.only(left: 35),
                    padding: const EdgeInsets.only(bottom: 4),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black),
                      ),
                    ),
                    child: const Text(
                      "현재 강의",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => ListClassRoomViewController.instance.lectures.value == -1
                      ? const Center(child: CupertinoActivityIndicator())
                      : TimeTable(
                          classRoom: ListClassRoomViewController.instance.classRoom.value,
                        ))
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
