import 'package:ai_gong/restAPI/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  static UserService get instance => Get.find<UserService>();

  Future<UserService> init() async {
    reflectAuth();
    return this;
  }

  void reflectAuth() async {
    var storage = const FlutterSecureStorage();
    ApiService.instance.dio.options.headers["Authorization"] = "Bearer ${await storage.read(key: "access_token") ?? "0000"}";
    var x = await storage.readAll();
    print(x);
  }

  void setAuth({required String access, required String refresh}) async {
    var storage = const FlutterSecureStorage();
    storage.write(key: 'access_token', value: access);
    storage.write(key: 'refresh_token', value: refresh);
    ApiService.instance.dio.options.headers["Authorization"] = "Bearer $access";
  }
}
