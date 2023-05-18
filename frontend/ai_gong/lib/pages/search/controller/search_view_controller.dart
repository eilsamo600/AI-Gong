import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:ai_gong/restAPI/response/get_classroom_list_response.dart';
import 'package:get/get.dart';

class SearchViewController extends GetxController {
  RxList<ClassRoom> classRoomList = RxList<ClassRoom>();

  Future<void> getClassRoomList() async {
    ApiResponse<ClassRoomListResponse> response =
        await ApiService.instance.getClassRoomList();
    if (response.result) {
      classRoomList.value = response.value!.classrooms!;
    }
    classRoomList.refresh();
  }
}
