import 'dart:math';

import 'package:ai_gong/common/common.dart';
import 'package:ai_gong/pages/list_classroom/controller/list_classroom_view_controller.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:flutter/material.dart';

class TimeTable extends StatelessWidget {
  final ClassRoom classRoom;
  const TimeTable({super.key, required this.classRoom});

  // List of days in a week
  static List week = ['월', '화', '수', '목', '금'];
  static var kColumnLength = 11;
  static double kFirstColumnHeight = 20;
  static double kBoxSize = 52;
  static double outwidth = 1.0;
  static double verticalwidth = 0.5;
  static double horizontalwidth = 0.5;
  @override
  Widget build(BuildContext context) {
    print(classRoom.lectures);
    classRoom.lectures ??= {};

    print(ListClassRoomViewController.instance.lectures.value);
    return Column(
      children: [
        Container(
          width: Common.getWidth,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(width: outwidth, color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              weekColumn(),
              ...classColumn(0),
              ...classColumn(1),
              ...classColumn(2),
              ...classColumn(3),
              ...classColumn(4)
            ],
          ),
        ),
      ],
    );
  }

  // Generates the columns for each day of the week
  List<Widget> classColumn(int index) {
    List removed = [];
    if (classRoom.lectures!.containsKey((index + 1).toString())) {
      int length = 1;
      if (classRoom.lectures![(index + 1).toString()].runtimeType == List) {
        length = classRoom.lectures![(index + 1).toString()]!.length;
      }
      for (var x = 0; x < length; x++) {
        if (classRoom.lectures![(index + 1).toString()]![x]['수업시간'] > 60) {
          for (var i = 0;
              i < classRoom.lectures![(index + 1).toString()]![x]['수업시간'] ~/ 60;
              i++) {
            removed.add(classRoom.lectures![(index + 1).toString()]![x]['시작시간']
                    .floor() +
                i);
          }
        }
      }
    }

    return [
      SizedBox(
        height: kColumnLength * kBoxSize + kFirstColumnHeight,
        child: VerticalDivider(
          color: Colors.grey,
          thickness: verticalwidth,
          width: 0.0,
        ),
      ),
      Expanded(
        flex: 4,
        child: Stack(children: [
          Column(
            children: [
              SizedBox(
                height: 20,
                child: Text(
                  '${week[index]}',
                  style: const TextStyle(fontSize: 11),
                ),
              ),
              ...List.generate(
                kColumnLength,
                (index) {
                  return Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        border: (removed.contains(index) != false)
                            ? const Border()
                            : Border(
                                top: BorderSide(
                                    color: Colors.grey,
                                    width: horizontalwidth)),
                      ),
                      height: kBoxSize,
                    )
                  ]);
                },
              ),
            ],
          ),
          if (classRoom.lectures!.containsKey((index + 1).toString()))
            ...List.generate(
              classRoom.lectures![(index + 1).toString()].runtimeType == List
                  ? classRoom.lectures![(index + 1).toString()]!.length
                  : 1,
              (idx) {
                return Positioned(
                  top: kFirstColumnHeight +
                      kBoxSize *
                          (classRoom.lectures![(index + 1).toString()]![idx]
                                  ['시작시간'] -
                              1),
                  height: kBoxSize *
                      (classRoom.lectures![(index + 1).toString()]![idx]
                              ['수업시간'] /
                          60.0),
                  width: 85,
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 1.0, bottom: 1.0, left: 2.5, right: 7.5),
                    color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withAlpha(50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          classRoom.lectures![(index + 1).toString()]![idx]
                              ['교과목명'],
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          classRoom.lectures![(index + 1).toString()]![idx]
                              ['담당교수'],
                          style: const TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
        ]),
      )
    ];
  }

  Expanded weekColumn() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: kFirstColumnHeight,
          ),
          ...List.generate(
            kColumnLength,
            (index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(color: Colors.grey, width: horizontalwidth),
                )),
                width: double.infinity,
                height: kBoxSize,
                child: Text(
                  '${index + 9}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
