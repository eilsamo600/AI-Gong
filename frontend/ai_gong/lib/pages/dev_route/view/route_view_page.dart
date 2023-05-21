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
                      html.WindowBase popupWin = html.window.open('https://ai-gong.com:8080/oauth2/authorization/google', 'name', 'width=600,height=400');
                    });
                  },
                  child: const Text('Login', style: TextStyle(color: Colors.black))),
              ElevatedButton(
                  onPressed: () async {
                    var storage = const FlutterSecureStorage();
                    await UserService.instance.setAuth(
                        access:
                            'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NDU2NjcyOSwiZW1haWwiOiJqa2c3MTcwQGdhY2hvbi5hYy5rciJ9.THgL9mGsdpMYqOOCgJNFffwU7N_JQCvHyzaazd1ntXIkcEwUgz2AWWj7YpIRn7icnAdXPV6PUY0EiAq6tLXo2A',
                        refresh:
                            'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJSZWZyZXNoVG9rZW4iLCJleHAiOjE2ODU4MDE0OTh9.oZCTImlBIoAruddDa01h_Z5AvmT0z5UocoQIPZBSbLEyTVvOMkzONcL5k_b1-oEJ0QArtw2C5lx7OJ9-zXGrWw');
                    await UserService.instance.loadUserInfo();
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
