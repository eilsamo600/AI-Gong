import 'package:ai_gong/pages/dev_route/controller/route_view_controller.dart';
import 'package:ai_gong/pages/main/view/main_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteViewPage extends StatelessWidget {
  const RouteViewPage({super.key});

  static const String url = '/route';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RouteViewController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text('RouteViewPage'),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(MainViewPage.url);
                  },
                  child: const Text('Main View Page', style: TextStyle(color: Colors.black)))
            ],
          ),
        ),
      ),
    );
  }
}
