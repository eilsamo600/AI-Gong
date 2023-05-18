import 'dart:html' as html;

import 'package:ai_gong/pages/dev_route/controller/route_view_controller.dart';
import 'package:ai_gong/pages/login/view/login_view_page.dart';
import 'package:ai_gong/pages/main/view/main_view_page.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;

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
                    Get.offAllNamed(MainViewPage.url);
                  },
                  child: const Text('Main View Page', style: TextStyle(color: Colors.black))),
              ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(LoginViewPage.url);
                  },
                  child: const Text('Login Page', style: TextStyle(color: Colors.black))),
              ElevatedButton(
                  onPressed: () async {
                    html.WindowBase? popupWin;
                    html.window.onMessage.listen((event) {
                      if (popupWin != null) {
                        popupWin.close();
                      }
                      var uri = Uri.dataFromString(event.data.toString());
                      Map<String, String> params = uri.queryParameters;
                      ApiService.instance.setAuth(refresh: params['refresh_token'] ?? "", access: params['access_token'] ?? "");
                    });

                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      html.WindowBase popupWin = html.window.open('http://localhost:8080/oauth2/authorization/google', 'name', 'width=600,height=400');
                    });
                  },
                  child: const Text('Login', style: TextStyle(color: Colors.black))),
              ElevatedButton(
                  onPressed: () async {
                    var storage = const FlutterSecureStorage();
                    var data = await storage.readAll();
                    print(data);
                  },
                  child: const Text('storage 확인'))
            ],
          ),
        ),
      ),
    );
  }
}
