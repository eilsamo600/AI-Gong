import 'dart:html' as html;

import 'package:ai_gong/Service/user_service.dart';
import 'package:ai_gong/pages/dev_route/controller/route_view_controller.dart';
import 'package:ai_gong/pages/main/view/main_view_page.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/Reservation.dart';
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
                  onPressed: () async {
                    html.WindowBase? popupWin;
                    html.window.onMessage.listen((event) {
                      if (popupWin != null) {
                        popupWin.close();
                      }
                      var uri = Uri.dataFromString(event.data.toString());
                      Map<String, String> params = uri.queryParameters;
                      UserService.instance.setAuth(refresh: params['refresh_token'] ?? "", access: params['access_token'] ?? "");
                    });

                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      html.WindowBase popupWin = html.window.open('http://localhost:8080/oauth2/authorization/google', 'name', 'width=600,height=400');
                    });
                  },
                  child: const Text('Login', style: TextStyle(color: Colors.black))),
              ElevatedButton(
                  onPressed: () async {
                    var storage = const FlutterSecureStorage();
                    UserService.instance.setAuth(
                        access:
                            'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NDQ5MDY3OSwiZW1haWwiOiJqa2c3MTcwQGdhY2hvbi5hYy5rciJ9.9RMlSVItfIKKUxzjUck_Rvg2OzMf38WKhgqXzyimpzx9Jz4t3Cq32HGWv4SdXvXT39Kf7k1jbPsF_EhFU5VNEQ',
                        refresh:
                            'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE2ODU2MjcwMjF9.3B9cGlZxTZ4iaGaHn4WRYGYIkDBJNdnmL-cgkEGan8f4mMhZEIHM_xxks4qrnZ6tu8MbgQ5HQjjU6oGhHmcjkQ');
                    var data = await storage.readAll();
                    print(data);
                  },
                  child: const Text('정민규로 로그인', style: TextStyle(color: Colors.black))),
              ElevatedButton(
                  onPressed: () async {
                    UserService.instance.login();
                  },
                  child: const Text('로그인', style: TextStyle(color: Colors.black))),
              ElevatedButton(
                  onPressed: () async {
                    var data = Reservation.fromJson({
                      'emai': '123',
                      //~~~
                    });
                    await ApiService.instance.postReservation(data);
                  },
                  child: const Text('ddddd'))
            ],
          ),
        ),
      ),
    );
  }
}
