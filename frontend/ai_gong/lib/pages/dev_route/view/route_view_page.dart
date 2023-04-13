import 'package:ai_gong/pages/dev_route/controller/route_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteViewPage extends StatelessWidget {
  const RouteViewPage({super.key});

  static const String url = '/route';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RouteViewController());
    return const Scaffold(
      body: Center(
        child: Text('RouteViewPage'),
      ),
    );
  }
}
