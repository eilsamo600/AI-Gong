import 'package:ai_gong/pages/dev_route/view/route_view_page.dart';
import 'package:get/get.dart';

// Summary:
// SplashController is used to control the splash view
class SplashController extends GetxController {
  @override
  void onReady() async {
    3.delay(() => Get.offAllNamed(RouteViewPage.url));
    super.onReady();
  }
}
