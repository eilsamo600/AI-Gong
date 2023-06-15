import 'package:dio/dio.dart';

// extension is used to add a function to a class
// This extension is used to check if the response is successful
extension DioExtension<T> on Response<T> {
  bool get isSuccessful => ((statusCode ?? 500) <= 300);
}
