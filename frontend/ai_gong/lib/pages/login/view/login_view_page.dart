import 'package:ai_gong/pages/login/controller/login_view_controller.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeTable extends StatelessWidget {
  final ClassRoom classRoom;
  const TimeTable({super.key, required this.classRoom});

  static List week = ['월', '화', '수', '목', '금'];
  static var kColumnLength = 11;
  static double kFirstColumnHeight = 20;
  static double kBoxSize = 52;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 450,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [weekColumn(), ...classColumn(0), ...classColumn(1), ...classColumn(2), ...classColumn(3), ...classColumn(4)],
          ),
        ),
      ],
    );
  }

  List<Widget> classColumn(int index) {
    return [
      SizedBox(
        height: kColumnLength * kBoxSize + kFirstColumnHeight,
        child: const VerticalDivider(
          color: Colors.grey,
          thickness: 0.3,
          width: 0,
        ),
      ),
      Expanded(
        flex: 4,
        child: Stack(children: [
          Positioned(
            top: kFirstColumnHeight + kBoxSize / 2,
            height: kBoxSize + kBoxSize * 0.5,
            width: 100,
            child: Container(
              color: Colors.green,
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
                child: Text(
                  '${week[index]}',
                ),
              ),
              ...List.generate(
                kColumnLength,
                (index) {
                  return Column(children: [
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.7,
                      height: 0,
                    ),
                    SizedBox(
                      height: kBoxSize,
                    )
                  ]);
                },
              ),
            ],
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
              return Column(children: [
                const Divider(
                  color: Colors.grey,
                  thickness: 0.7,
                  height: 0,
                ),
                SizedBox(
                  height: kBoxSize,
                  child: Center(child: Text('${index + 9}')),
                )
              ]);
            },
          ),
        ],
      ),
    );
  }
}

class LoginViewPage extends StatelessWidget {
  const LoginViewPage({super.key});

  static const String url = '/login';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginViewController());
    return Scaffold(
        body: TimeTable(
      classRoom: ClassRoom.fromJson({'강의목록': ''}),
    ));
  }
}
