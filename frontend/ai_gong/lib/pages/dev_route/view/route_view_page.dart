import 'dart:html' as html;

import 'package:ai_gong/pages/dev_route/controller/route_view_controller.dart';
// import 'package:ai_gong/pages/login/view/login_view_page.dart';
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
                  child: const Text('Main View Page',
                      style: TextStyle(color: Colors.black))),
              ElevatedButton(
                  onPressed: () {
                    //Get.offAllNamed(LoginViewPage.url);
                  },
                  child: const Text('Login Page',
                      style: TextStyle(color: Colors.black))),
              // ElevatedButton(
              //     onPressed: () {
              //       Get.offAllNamed(LoginViewPage.url);
              //     },
              //     child: const Text('Login Page',
              //         style: TextStyle(color: Colors.black))),
              ElevatedButton(
                  onPressed: () async {
                    html.WindowBase? popupWin;
                    html.window.onMessage.listen((event) {
                      if (popupWin != null) {
                        popupWin.close();
                      }
                      var uri = Uri.dataFromString(event.data.toString());
                      Map<String, String> params = uri.queryParameters;
                      ApiService.instance.setAuth(
                          refresh: params['refresh_token'] ?? "",
                          access: params['access_token'] ?? "");
                    });

                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      html.WindowBase popupWin = html.window.open(
                          'http://localhost:8080/oauth2/authorization/google',
                          'name',
                          'width=600,height=400');
                    });
                  },
                  child: const Text('Login',
                      style: TextStyle(color: Colors.black))),
              ElevatedButton(
                  onPressed: () async {
                    var storage = const FlutterSecureStorage();
                    ApiService.instance.setAuth(
                        access:
                            'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NDQyMTAyMSwiZW1haWwiOiJqa2c3MTcwQGdhY2hvbi5hYy5rciJ9.Rh9O1p4DfpoawJd_lMWS9_IHxSVh4MsUJ-wJZdW3qPIVncMl8YcPwo87por8NKm9LYJtmrIsExYCltksEdpg0Q',
                        refresh:
                            'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE2ODU2MjcwMjF9.3B9cGlZxTZ4iaGaHn4WRYGYIkDBJNdnmL-cgkEGan8f4mMhZEIHM_xxks4qrnZ6tu8MbgQ5HQjjU6oGhHmcjkQ');
                    var data = await storage.readAll();
                    print(data);
                  },
                  child: const Text('storage 확인')),
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
