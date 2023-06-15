// Summary:
// Api response class for handling api response
// This class is used to check if the response is successful

class ApiResponse<T> {
  ApiResponse({required this.result, this.value, this.errorMsg = ''});

  String errorMsg;
  bool result;
  T? value;
}
