import 'package:get/get.dart';
import 'package:logger/logger.dart';

class Common extends GetxService {
  static const bool isDev = true;
  static Logger logger = Logger(filter: MyFilter());
  static const String baseUrl = "http://43.201.81.76:8000/";
  Future<Common> init() async {
    Common.logger.d('$runtimeType init!');
    return this;
  }
}

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return Common.isDev ? true : false;
  }
}
