import 'package:ai_gong/pages/list_classroom/controller/list_classroom_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FilterComponent extends StatelessWidget {
  final int index;
  const FilterComponent({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = ListClassRoomViewController.instance;
    return Obx(() {
      final onTap = controller.onTapList[index];
      return GestureDetector(
        onTap: () {
          ListClassRoomViewController.instance.selectFilter(index);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: onTap ? const Color.fromRGBO(238, 244, 250, 1.0) : Colors.white,
            border: onTap ? const Border() : Border.all(color: Colors.grey, width: 0.2),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 25,
          child: Text(
            '필터',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: onTap ? const Color.fromRGBO(75, 130, 238, 1.0) : Colors.black54),
          ),
        ),
      );
    });
  }
}
