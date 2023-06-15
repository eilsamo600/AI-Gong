import 'dart:convert';
import 'dart:math';

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

// Summary:
// ApiService is used to communicate with the server
// This class is used in the controller
class ApiService extends GetxService {
  static ApiService get instance => Get.find<ApiService>();

  // Dio is a powerful Http client for Dart, which supports Interceptors, FormData, Request Cancellation, File Downloading, Timeout etc.
  // https://pub.dev/packages/dio
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

  /*
   Get Request, getClassRoomList()
    This function is used to get the list of classrooms from the server
    Args:
      None
    Returns:
      ApiResponse<ClassRoomListResponse> : The response from the server, which contains the list of classrooms
  */
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

  /*
   Get Request, getClassRoomListByLike()
    This function is used to get the list of classrooms from the server
    Args:
      None
    Returns:
      ApiResponse<ClassRoomListResponse> : The response from the server, which contains the list of classrooms
  */
  Future<ApiResponse<ClassRoomListResponse>> getClassRoomListByLike() async {
    try {
      var response = await dio.get(
        '/classroom/classrooms/like',
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

  /*
    Get Request, getUserInfo()
    This function is used to get the user information from the server
    Args:
      None
    Returns:
      ApiResponse<UserResponse> : The response from the server, which contains the user information
  */
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

  /*
    Get Request, getClassRoom()
      This function is used to get the information of a classroom from the server
      Args:
        int id : The id of the classroom
      Returns:
        ApiResponse<ClassRoomResponse> : The response from the server, which contains the information of the classroom
  */
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

  /*
    Get Request, postLikeAndClassroom()
      This function is used to like a classroom
      Args:
        String roomid : The id of the classroom
      Returns:
        ApiResponse<ClassRoomResponse> : The response from the server, which contains the information of the classroom
  */
  Future<ApiResponse<ClassRoomResponse>> postLikeAndClassroom(
      String roomid) async {
    try {
      var response = await dio.post(
        '/classroom/classroom/$roomid/like',
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

  /*
    Get Request, getIncubatorList()
      This function is used to get the list of incubators from the server
      Args:
        None
      Returns:
        ApiResponse<IncubatorListResponse> : The response from the server, which contains the list of incubators
  */
  Future<ApiResponse<IncubatorListResponse>> getIncubatorList() async {
    try {
      var response = await dio.get(
        '/incubator/incubators',
        data: jsonEncode({}),
      );
      IncubatorListResponse getIncubatorListResponse =
          IncubatorListResponse.fromJson(response.data);
      print(getIncubatorListResponse.toString());
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

  /*
    Get Request, getReservationList()
      This function is used to get the list of reservations from the server
      Args:
        String email : The email of the user
      Returns:
        ApiResponse<ReservationListResponse> : The response from the server, which contains the list of reservations
   */
  Future<ApiResponse<ReservationListResponse>> getReservationList(
      String email) async {
    try {
      var response = await dio.get(
        '/reservation',
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

  /*
    Post Request, postReservationState()
      This function is used to change the state of a reservation
      Args:
        String id : The id of the reservation
        int state : The state of the reservation
      Returns:
        ApiResponse : The response from the server
  */
  Future<ApiResponse> postReservationState(String id, int state) async {
    try {
      var response = await dio.post(
        '/reservation/reservation/$id/$state',
        data: jsonEncode({}),
      );
      return ApiResponse(result: true);
    } catch (e) {
      return ApiResponse(result: false, errorMsg: "오류가 발생했습니다.");
    }
  }

  /*
    Delete Request, deleteReservation()
      This function is used to delete a reservation
      Args:
        String id : The id of the reservation
      Returns:
        ApiResponse : The response from the server
  */
  Future<ApiResponse> deleteReservation(String id) async {
    try {
      var response = await dio.delete(
        '/reservation/reservation/$id',
        data: jsonEncode({}),
      );
      return ApiResponse(result: true);
    } catch (e) {
      return ApiResponse(result: false, errorMsg: "오류가 발생했습니다.");
    }
  }

  /*
    Get Request, getIncubator()
      This function is used to get the information of an incubator
      Args:
        int id : The id of the incubator
      Returns:
        ApiResponse<IncubatorResponse> : The response from the server, which contains the information of the incubator
  */
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

  /*
    Post Request, postReservation()
      This function is used to post a reservation
      Args:
        Reservation data : The reservation data to be posted
      Returns:
        ApiResponse : The response from the server
   */
  Future<ApiResponse> postReservation(Reservation data) async {
    try {
      var response = await dio.post(
        '/reservation/reservation',
        data: jsonEncode(data.toJson()),
      );
      return ApiResponse(result: true);
    } catch (e) {
      return ApiResponse(result: false, errorMsg: "오류가 발생했습니다.");
    }
  }

  /*
    Get Request, getAvailableReservation()
      This function is used to get the available reservation of an incubator
      Args:
        String number : The number of the incubator
        String date : The date of the reservation
      Returns:
        ApiResponse<AvailableReservationResponse> : The response from the server, which contains the available reservation of the incubator
  */
  Future<ApiResponse<AvailableReservationResponse>> getAvailableReservation(
      String number, String date) async {
    try {
      var response = await dio.get(
        '/reservation/reservation/$number/$date',
        data: jsonEncode({}),
      );
      AvailableReservationResponse getReservationResponse =
          AvailableReservationResponse.fromJson(response.data);
      Common.logger.d(e);
      return ApiResponse<AvailableReservationResponse>(
          result: response.isSuccessful, value: getReservationResponse);
    } on DioError catch (e) {
      // Common.logger.d(e);
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
