import 'package:ai_gong/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
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
