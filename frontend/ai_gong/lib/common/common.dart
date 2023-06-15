import 'package:ai_gong/Service/user_service.dart';
import 'package:ai_gong/common/widget/panel_component.dart';
import 'package:ai_gong/pages/main/controller/main_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// Common Service
// This service is used to store common variables and function related to the app
class Common extends GetxService {
  static Common get instance => Get.find<Common>();
  static const bool isDev = true;
  static Logger logger = Logger(filter: MyFilter());
  // baseUrl is the base url of the backend server
  static const String baseUrl = "https://ai-gong.com:8000/";
  // authbaseUrl is the base url of the auth server
  static const String authbaseUrl = "https://ai-gong.com:8003/";

  // getWidth is used to get the width of the screen
  static double get getWidth => GetPlatform.isMobile ? Get.width : 500;

  // This function is used to display a snackbar
  static SnackbarController showSnackBar(
      {required String messageText,
      Color textColor = Colors.white,
      Color backgroundColor = const Color.fromARGB(255, 45, 45, 45),
      dynamic position = SnackPosition.TOP}) {
    return Get.rawSnackbar(
      borderRadius: 0,
      snackPosition: position,
      margin: position == SnackPosition.BOTTOM ? const EdgeInsets.only(top: 16, left: 16, right: 16) : const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      messageText: Text(
        messageText,
        style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.normal),
      ),
      backgroundColor: backgroundColor,
    );
  }

  // This function is used to display a dialog
  static void showAlertDialog({required BuildContext context, required String title, required List<Widget> children, List<Widget>? actions}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
          actions: actions ??
              <Widget>[
                TextButton(
                  child: const Text(
                    '확인',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
        );
      },
    );
  }

  // This function is used to display a dialog
  // loginPanel is used to display a login panel
  static void loginPanel() async {
    showModalBottomSheet(
        isScrollControlled: true,
        context: Get.context!,
        builder: ((context) {
          return SizedBox(
            height: 200,
            child: PanelComponent(
              radius: 15,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('AiGong', style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('간단하게 로그인 하고', style: TextStyle(fontSize: 19, color: Colors.black)),
                              SizedBox(
                                height: 5,
                              ),
                              Text('더 많은 애공 서비스 누리기', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: SizedBox(
                      width: 300,
                      height: 40,
                      child: ButtonTheme(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                if (!await UserService.instance.isLogin()) {
                                  bool x = await UserService.instance.login();
                                  Navigator.pop(context);
                                  if (x) MainViewController.instance.selectTab(2);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/google.png', width: 25),
                                    const SizedBox(width: 15),
                                    const Text('Google 계정으로 로그인하기', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ))),
                    ),
                  ),
                ]),
              ),
            ),
          );
        }));
  }

  // init is used to initialize the service
  Future<Common> init() async {
    Common.logger.d('$runtimeType init!');
    return this;
  }

  // getNowTime is used to get the current time
  String getNowTime(DateTime now) {
    return '${now.hour > 12 ? '오후' : '오전'} ${now.hour > 12 ? now.hour - 12 : now.hour == 0 ? 12 : now.hour}시 ${now.minute}분';
  }

// getNowWeek is used to get the current week
  String getNowWeek(DateTime now) {
    switch (now.weekday) {
      case 1:
        return '월요일';
      case 2:
        return '화요일';
      case 3:
        return '수요일';
      case 4:
        return '목요일';
      case 5:
        return '금요일';
      case 6:
        return '토요일';
      case 7:
        return '일요일';
      default:
        return '';
    }
  }
}

// MyFilter is used to filter the log
class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return Common.isDev ? true : false;
  }
}
