import 'package:ai_gong/pages/dev_route/view/route_view_page.dart';
import 'package:ai_gong/pages/list_incubator/view/list_incubator_view_page.dart';
import 'package:ai_gong/pages/login/view/login_view_page.dart';
import 'package:ai_gong/pages/main/view/main_view_page.dart';
import 'package:ai_gong/pages/my_info/view/my_info_view_page.dart';
import 'package:ai_gong/pages/search/view/search_view_page.dart';
import 'package:get/get.dart';

class CustomRouter {
  static final routes = [
    GetPage(
      name: RouteViewPage.url,
      page: () => const RouteViewPage(),
    ),
    GetPage(name: MainViewPage.url, page: () => const MainViewPage()),
    GetPage(name: MyInfoViewPage.url, page: () => const MyInfoViewPage()),
    GetPage(name: SearchViewPage.url, page: () => const SearchViewPage()),
    GetPage(name: LoginViewPage.url, page: () => const LoginViewPage()),
    GetPage(
        name: ListIncubatorViewPage.url,
        page: () => const ListIncubatorViewPage())
  ];
}
