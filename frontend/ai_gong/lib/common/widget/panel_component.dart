import 'package:ai_gong/common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanelComponent extends StatelessWidget {
  Widget child;
  PanelComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Transparent container to capture tap events and dismiss the panel
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.transparent,
            height: Get.height,
            width: Get.width,
          ),
        ),
        // Panel content
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
              height: Get.height * 0.8,
              width: Common
                  .getWidth, // Assuming Common.getWidth is a valid width value
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: SingleChildScrollView(child: child)),
        )
      ],
    );
  }
}
