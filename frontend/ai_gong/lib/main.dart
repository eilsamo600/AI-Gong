import 'package:ai_gong/common/common.dart';
import 'package:ai_gong/pages/splash/view/splash_view_page.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await initServices();
  runApp(GetMaterialApp(
    initialRoute: SplashViewPage.url,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        canvasColor: Colors.transparent,
        backgroundColor: Colors.white,
        fontFamily: 'NotoSansKR',
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: Colors.white,
        ),
        appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: Colors.black))),
    getPages: CustomRouter.routes,
    themeMode: ThemeMode.light,
  ));
}

Future<void> initServices() async {
  await Get.putAsync(() => Common().init());
  await Get.putAsync(() => ApiService().init());
}
