import 'dart:convert';

import 'package:ai_gong/common/common.dart';
import 'package:ai_gong/common/dio_extension.dart';
import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/response/get_classroom_list_response.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService extends GetxService {
  Dio dio = Dio(BaseOptions(baseUrl: Common.baseUrl));
  Options dioOptions = Options();
  Future<ApiService> init() async {
    Common.logger.d('$runtimeType init!');
    if (Common.isDev) {
      dio.interceptors.add(PrettyDioLogger());
    }
    return this;
  }

  Future<ApiResponse<ClassRoomListResponse>> getClassroomList() async {
    try {
      var response = await dio.post(
        '/classroom/classrooms',
        data: jsonEncode({}),
      );
      ClassRoomListResponse getClassRoomListResponse = ClassRoomListResponse.fromJson(response.data);
      return ApiResponse<ClassRoomListResponse>(result: response.isSuccessful, value: getClassRoomListResponse);
    } on DioError catch (e) {
      Common.logger.d(e);
      try {
        return ApiResponse<ClassRoomListResponse>(result: false, errorMsg: e.response?.data['message'] ?? "오류가 발생했습니다.");
      } catch (e) {
        return ApiResponse<ClassRoomListResponse>(result: false, errorMsg: "오류가 발생했습니다.");
      }
    } catch (e) {
      return ApiResponse<ClassRoomListResponse>(result: false, errorMsg: "오류가 발생했습니다.");
    }
  }
}
