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
          controller.scrollcontroller.value.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
          if (index == 0) {
            controller.restFilter();
            Future.delayed(const Duration(milliseconds: 350), () => controller.getClassRoomList());
            return;
          }

          controller.selectFilter(index);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: onTap ? const Color.fromRGBO(238, 244, 250, 1.0) : Colors.white,
            border: Border.all(color: onTap ? Colors.transparent : Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 25,
          child: index == 0
              ? const Icon(
                  Icons.refresh,
                  size: 15,
                  color: Colors.black54,
                )
              : Text(
                  controller.filterList[index],
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: onTap ? const Color.fromRGBO(75, 130, 238, 1.0) : Colors.black54),
                ),
        ),
      );
    });
  }
}
