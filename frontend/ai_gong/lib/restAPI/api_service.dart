import 'dart:convert';

import 'package:ai_gong/common/common.dart';
import 'package:ai_gong/common/dio_extension.dart';
import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/models/Reservation.dart';
import 'package:ai_gong/restAPI/response/get_available_reservation.dart';
import 'package:ai_gong/restAPI/response/get_classroom_list_response.dart';
import 'package:ai_gong/restAPI/response/get_classroom_response.dart';
import 'package:ai_gong/restAPI/response/get_incubator_list_response.dart';
import 'package:ai_gong/restAPI/response/get_incubator_response.dart';
import 'package:ai_gong/restAPI/response/get_reservation_list_response.dart';
import 'package:ai_gong/restAPI/response/get_user.response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService extends GetxService {
  static ApiService get instance => Get.find<ApiService>();

  Dio dio = Dio(BaseOptions(
      baseUrl: Common.baseUrl,
      headers: {"Flutter-Rest-Api": "true", "Authorization": "Bearer 0000"}));
  Future<ApiService> init() async {
    Common.logger.d('$runtimeType init!');
    if (Common.isDev) {
      dio.interceptors.add(PrettyDioLogger());
    }
    return this;
  }

  Future<ApiResponse<ClassRoomListResponse>> getClassRoomList() async {
    try {
      var response = await dio.get(
        '/classroom/classrooms',
        data: jsonEncode({}),
      );
      ClassRoomListResponse getClassRoomListResponse =
          ClassRoomListResponse.fromJson(response.data);
      return ApiResponse<ClassRoomListResponse>(
          result: response.isSuccessful, value: getClassRoomListResponse);
    } on DioError catch (e) {
      Common.logger.d(e);
      try {
        return ApiResponse<ClassRoomListResponse>(
            result: false,
            errorMsg: e.response?.data['message'] ?? "오류가 발생했습니다.");
      } catch (e) {
        return ApiResponse<ClassRoomListResponse>(
            result: false, errorMsg: "오류가 발생했습니다.");
      }
    } catch (e) {
      return ApiResponse<ClassRoomListResponse>(
          result: false, errorMsg: "오류가 발생했습니다.");
    }
  }

  Future<ApiResponse<UserResponse>> getUserInfo() async {
    try {
      var storage = const FlutterSecureStorage();
      Dio authdio = Dio(BaseOptions(baseUrl: Common.authbaseUrl, headers: {
        "Flutter-Rest-Api": "true",
        "Authorization":
            "Bearer ${await storage.read(key: "access_token") ?? "0000"}"
      }));
      var response = await authdio.get(
        '/info',
        data: jsonEncode({}),
      );
      UserResponse getUserResponse = UserResponse.fromJson(response.data);
      return ApiResponse<UserResponse>(
          result: response.isSuccessful, value: getUserResponse);
    } on DioError catch (e) {
      Common.logger.d(e);
      try {
        return ApiResponse<UserResponse>(
            result: false,
            errorMsg: e.response?.data['message'] ?? "오류가 발생했습니다.");
      } catch (e) {
        return ApiResponse<UserResponse>(
            result: false, errorMsg: "오류가 발생했습니다.");
      }
    } catch (e) {
      return ApiResponse<UserResponse>(result: false, errorMsg: "오류가 발생했습니다.");
    }
  }

  Future<ApiResponse<ClassRoomResponse>> getClassRoom(int id) async {
    try {
      var response = await dio.get(
        '/classroom/classroom/$id',
        data: jsonEncode({}),
      );
      ClassRoomResponse getClassRoomResponse =
          ClassRoomResponse.fromJson(response.data);
      return ApiResponse<ClassRoomResponse>(
          result: response.isSuccessful, value: getClassRoomResponse);
    } on DioError catch (e) {
      Common.logger.d(e);
      try {
        return ApiResponse<ClassRoomResponse>(
            result: false,
            errorMsg: e.response?.data['message'] ?? "오류가 발생했습니다.");
      } catch (e) {
        return ApiResponse<ClassRoomResponse>(
            result: false, errorMsg: "오류가 발생했습니다.");
      }
    } catch (e) {
      return ApiResponse<ClassRoomResponse>(
          result: false, errorMsg: "오류가 발생했습니다.");
    }
  }

  Future<ApiResponse<IncubatorListResponse>> getIncubatorList() async {
    try {
      var response = await dio.get(
        '/incubator/incubators',
        data: jsonEncode({}),
      );
      IncubatorListResponse getIncubatorListResponse =
          IncubatorListResponse.fromJson(response.data);

      return ApiResponse<IncubatorListResponse>(
          result: response.isSuccessful, value: getIncubatorListResponse);
    } on DioError catch (e) {
      Common.logger.d(e);
      try {
        return ApiResponse<IncubatorListResponse>(
            result: false,
            errorMsg: e.response?.data['message'] ?? "오류가 발생했습니다.");
      } catch (e) {
        return ApiResponse<IncubatorListResponse>(
            result: false, errorMsg: "오류가 발생했습니다.");
      }
    } catch (e) {
      return ApiResponse<IncubatorListResponse>(
          result: false, errorMsg: "오류가 발생했습니다.");
    }
  }

  Future<ApiResponse<ReservationListResponse>> getReservationList(
      String email) async {
    try {
      var response = await dio.get(
        '/reservation/$email',
        data: jsonEncode({}),
      );
      ReservationListResponse getReservationListResponse =
          ReservationListResponse.fromJson(response.data);
      return ApiResponse<ReservationListResponse>(
          result: response.isSuccessful, value: getReservationListResponse);
    } on DioError catch (e) {
      Common.logger.d(e);
      try {
        return ApiResponse<ReservationListResponse>(
            result: false,
            errorMsg: e.response?.data['message'] ?? "오류가 발생했습니다.");
      } catch (e) {
        return ApiResponse<ReservationListResponse>(
            result: false, errorMsg: "오류가 발생했습니다.");
      }
    } catch (e) {
      return ApiResponse<ReservationListResponse>(
          result: false, errorMsg: "오류가 발생했습니다.");
    }
  }

  Future<ApiResponse<IncubatorResponse>> getIncubator(int id) async {
    try {
      var response = await dio.get(
        '/incubator/incubator/$id',
        data: jsonEncode({}),
      );
      IncubatorResponse getIncubatorResponse =
          IncubatorResponse.fromJson(response.data);
      return ApiResponse<IncubatorResponse>(
          result: response.isSuccessful, value: getIncubatorResponse);
    } on DioError catch (e) {
      Common.logger.d(e);
      try {
        return ApiResponse<IncubatorResponse>(
            result: false,
            errorMsg: e.response?.data['message'] ?? "오류가 발생했습니다.");
      } catch (e) {
        return ApiResponse<IncubatorResponse>(
            result: false, errorMsg: "오류가 발생했습니다.");
      }
    } catch (e) {
      return ApiResponse<IncubatorResponse>(
          result: false, errorMsg: "오류가 발생했습니다.");
    }
  }

  Future<ApiResponse> postReservation(Reservation data) async {
    try {
      var response = await dio.post(
        '/reservation',
        data: jsonEncode(data.toJson()),
      );
      return ApiResponse(result: true);
    } catch (e) {
      return ApiResponse(result: false, errorMsg: "오류가 발생했습니다.");
    }
  }

  Future<ApiResponse<AvailableReservationResponse>> getAvailableReservation(
      String number, String date) async {
    try {
      var response = await dio.get(
        '/reservation/$number/$date',
        data: jsonEncode({}),
      );
      AvailableReservationResponse getReservationResponse =
          AvailableReservationResponse.fromJson(response.data);

      return ApiResponse<AvailableReservationResponse>(
          result: response.isSuccessful, value: getReservationResponse);
    } on DioError catch (e) {
      Common.logger.d(e);
      try {
        return ApiResponse<AvailableReservationResponse>(
            result: false,
            errorMsg: e.response?.data['message'] ?? "오류가 발생했습니다.");
      } catch (e) {
        return ApiResponse<AvailableReservationResponse>(
            result: false, errorMsg: "오류가 발생했습니다.");
      }
    } catch (e) {
      return ApiResponse<AvailableReservationResponse>(
          result: false, errorMsg: "오류가 발생했습니다.");
    }
  }
}
