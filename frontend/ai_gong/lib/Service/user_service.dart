import 'dart:html' as html;
import 'dart:html';

import 'package:ai_gong/common/common.dart';
import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/pages/main/controller/main_view_controller.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/User.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;

// Summary:
// UserService is used to manage the user information
// This class is used in the controller
class UserService extends GetxService {
  static UserService get instance => Get.find<UserService>();

  bool logining = false;
  Rx<User> user = User().obs;
  /*
  * init() is used to initialize the user information
  * @param: none
  * @return: UserService, the instance of the UserService
  */
  Future<UserService> init() async {
    Common.logger.d('$runtimeType init!');
    await loadUserInfo();

    return this;
  }

  /*
  * loadUserInfo() is used to load the user information
  * @param: none
  * @return: none
  */
  Future<void> loadUserInfo() async {
    var storage = const FlutterSecureStorage();
    ApiService.instance.dio.options.headers["Authorization"] = "Bearer ${await storage.read(key: "access_token") ?? "0000"}";
    ApiResponse response = await ApiService.instance.getUserInfo();
    if (response.result) {
      print('정보 가져오기 성공');
      user.value = response.value.user;
    } else {
      print('정보 가져오기 실패');
      try {
        Dio dio = Dio(BaseOptions(baseUrl: Common.authbaseUrl, headers: {
          "Flutter-Rest-Api": "true",
          "authorization-refresh": "Bearer ${await storage.read(key: "refresh_token") ?? "0000"}",
        }));
        Response response = await dio.get('/info');
        print('refresh Token을 통한 새 Token 발급');

        await setAuth(access: response.headers.value('authorization') ?? '', refresh: response.headers.value('authorization-refresh') ?? '');
        await loadUserInfo();
      } catch (e) {
        print('refresh Token 만료');
        await setAuth(access: "", refresh: "");
      }
    }
    var x = await storage.readAll();
    print(x);
  }

  /*
  * setAuth() is used to set the user information
  * @param: String refresh, the access token
  * @param: String refresh, the refresh token
  */
  Future<void> setAuth({required String access, required String refresh}) async {
    var storage = const FlutterSecureStorage();
    ApiService.instance.dio.options.headers["Authorization"] = "Bearer $access";
    await storage.write(key: 'access_token', value: access);
    await storage.write(key: 'refresh_token', value: refresh);
  }
  /*
  * isLogin() is used to check if the user is logged in
  * @param: none
  * @return: bool, true if the user is logged in, false if the user is not logged in
  */

  Future<bool> isLogin() async {
    var storage = const FlutterSecureStorage();
    return (await storage.read(key: "access_token") ?? '') != '' ? logining : false;
  }

  /*
  * logout() is used to log out the user
  * @param: none
  * @return: none
  */

  void logout() async {
    var storage = const FlutterSecureStorage();
    MainViewController.instance.selectTab(0);
    await storage.deleteAll();
    await setAuth(refresh: "", access: "");
    logining = false;

    Common.showSnackBar(messageText: '로그아웃이 되었습니다.');
  }

/*
  * login() is used to log in the user
  * @param: none
  * @return: bool, true if the user is logged in, false if the user is not logged in
  */
  
  Future<bool> login() async {
    try {
      logining = true;
      html.WindowBase? popupWin;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        popupWin = html.window.open('https://ai-gong.com:8003/oauth2/authorization/google', 'name', 'width=600,height=400');
      });
      final stream = html.window.onMessage.timeout(const Duration(seconds: 30), onTimeout: (sink) {
        sink.add(MessageEvent('timeout'));
      });

      await for (var event in stream) {
        if (event.type == 'timeout') {
          logining = false;
          Common.showSnackBar(messageText: '로그인이 시간내에 완료되지 않았습니다.');
          if (popupWin != null) {
            popupWin!.close();
          }
          return false;
        }
        var uri = Uri.dataFromString(event.data.toString());
        Map<String, String> params = uri.queryParameters;
        await setAuth(refresh: params['refresh_token'] ?? "", access: params['access_token'] ?? "");
        await UserService.instance.loadUserInfo();
        Common.showSnackBar(messageText: '로그인이 완료되었습니다.');
        if (popupWin != null) {
          popupWin!.close();
        }
        return true;
      }
    } on Exception {
      Common.showSnackBar(messageText: '로그인을 실패하였습니다.');
    }
    return false;
  }
}
