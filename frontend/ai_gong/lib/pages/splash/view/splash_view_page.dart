import 'package:ai_gong/pages/splash/controller/splash_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashViewPage extends StatelessWidget {
  const SplashViewPage({super.key});

  static const String url = '/';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 0),
      body: Center(
        //     child: Image.asset(
        //   'assets/images/icon.png',
        //   width: 100,
        // )
        child: Text('SplashViewPage'),
      ),
    );
  }
}
