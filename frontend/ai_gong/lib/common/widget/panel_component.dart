import 'package:ai_gong/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanelComponent extends StatelessWidget {
  Widget child;
  double radius;
  PanelComponent({
    super.key,
    required this.child,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.transparent,
            height: Get.height,
            width: Get.width,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
              height: Get.height * 0.8,
              width: Common.getWidth,
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius))),
              child: SingleChildScrollView(child: child)),
        )
      ],
    );
  }
}
