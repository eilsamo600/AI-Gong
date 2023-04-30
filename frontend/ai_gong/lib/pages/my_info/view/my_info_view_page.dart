import 'package:ai_gong/pages/my_info/controller/my_info_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInfoViewPage extends StatelessWidget {
  const MyInfoViewPage({super.key});

  static const String url = '/info';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyInfoViewController());
    return const Scaffold(
      body: Text('내 정보 페이지'),
    );
  }
}
