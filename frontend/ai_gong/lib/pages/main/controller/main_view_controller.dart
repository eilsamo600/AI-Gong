import 'package:ai_gong/pages/list_classroom/view/list_classroom_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainViewController extends GetxController {
  RxInt pageIndex = 0.obs;

  void selectTab(int index) {
    pageIndex.value = index;
    update();
  }

  static MainViewController get instance => Get.find<MainViewController>();
  final List<Widget> bodyContent = [const ListClassRoomViewPage()];
}
