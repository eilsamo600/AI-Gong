import 'package:ai_gong/pages/login/controller/login_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewPage extends StatelessWidget {
  const LoginViewPage({super.key});

  static const String url = '/login';
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginViewController());
    return const Scaffold(body: Text('로그인 페이지'));
  }
}
