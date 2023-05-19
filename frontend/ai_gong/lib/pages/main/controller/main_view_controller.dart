import 'package:ai_gong/Service/UserService.dart';
import 'package:ai_gong/common/common.dart';
import 'package:ai_gong/pages/list_classroom/view/list_classroom_view_page.dart';
import 'package:ai_gong/pages/list_incubator/view/list_incubator_view_page.dart';
import 'package:ai_gong/pages/my_info/view/my_info_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainViewController extends GetxController {
  RxInt pageIndex = 0.obs;

  void selectTab(int index) async {
    if (index == 2) {
      bool islogin = await UserService.instance.isLogin();
      if (!islogin) {
        Common.loginPanel();
        return;
      }
    }
    pageIndex.value = index;
    update();
  }

  static MainViewController get instance => Get.find<MainViewController>();
  final List<Widget> bodyContent = [const ListClassRoomViewPage(), const ListIncubatorViewPage(), const MyInfoViewPage()];
}
