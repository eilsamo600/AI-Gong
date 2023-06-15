import 'package:ai_gong/Service/user_service.dart';
import 'package:ai_gong/common/common.dart';
import 'package:ai_gong/pages/list_classroom/view/list_classroom_view_page.dart';
import 'package:ai_gong/pages/list_incubator/controller/list_incubator_view_controller.dart';
import 'package:ai_gong/pages/list_incubator/view/list_incubator_view_page.dart';
import 'package:ai_gong/pages/my_info/controller/my_info_view_controller.dart';
import 'package:ai_gong/pages/my_info/view/my_info_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Summary:
// MainViewController is used to control the main view
// This controller is GetX controller
class MainViewController extends GetxController {
  RxInt pageIndex = 0.obs;

  void selectTab(int index) async {
    if (index == 2) {
      bool islogin = await UserService.instance.isLogin();
      if (!islogin) {
        Common.loginPanel();
        return;
      }
      await MyInfoViewController.instance.getMyReservationList();
    }
    if (index == 1) {
      ListIncubatorViewController.instance.getIncubatorList();
    }
    pageIndex.value = index;
    update();
  }

  static MainViewController get instance => Get.find<MainViewController>();
  final List<Widget> bodyContent = [const ListClassRoomViewPage(), const ListIncubatorViewPage(), const MyInfoViewPage()];
}
