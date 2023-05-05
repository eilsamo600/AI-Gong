import 'package:get/get.dart';
import 'package:logger/logger.dart';

class Common extends GetxService {
  static Common get instance => Get.find<Common>();
  static const bool isDev = true;
  static Logger logger = Logger(filter: MyFilter());
  static const String baseUrl = "http://43.201.81.76:8000/";

  static double get getWidth => GetPlatform.isMobile ? Get.width : 500;

  Future<Common> init() async {
    Common.logger.d('$runtimeType init!');
    return this;
  }

  String getNowTime(DateTime now) {
    return '${now.hour > 12 ? '오후' : '오전'} ${now.hour > 12 ? now.hour == 0 ? 12 : now.hour - 12 : now.hour}시 ${now.minute}분';
  }

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

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return Common.isDev ? true : false;
  }
}
