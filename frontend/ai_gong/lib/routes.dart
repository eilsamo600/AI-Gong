import 'package:ai_gong/pages/dev_route/view/route_view_page.dart';
import 'package:ai_gong/pages/main/view/main_view_page.dart';
import 'package:ai_gong/pages/splash/view/splash_view_page.dart';
import 'package:get/get.dart';

class CustomRouter {
  static final routes = [
    GetPage(
      name: SplashViewPage.url,
      page: () => const SplashViewPage(),
    ),
    GetPage(
      name: RouteViewPage.url,
      page: () => const RouteViewPage(),
    ),
    GetPage(name: MainViewPage.url, page: () => const MainViewPage())
  ];
}
