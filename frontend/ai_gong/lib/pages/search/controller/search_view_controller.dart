import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/models/Classroom.dart';
import 'package:ai_gong/restAPI/response/get_classroom_list_response.dart';
import 'package:get/get.dart';

class SearchViewController extends GetxController {
  RxList<ClassRoom> classRoomList = RxList<ClassRoom>();
  RxList<ClassRoom> storeList = RxList<ClassRoom>();

  @override
  void onInit() async {
    super.onInit();
    await getClassRoomList();
  }

  Future<void> getClassRoomList() async {
    ApiResponse<ClassRoomListResponse> response =
        await ApiService.instance.getClassRoomList();
    if (response.result) {
      storeList.value = response.value!.classrooms!;
    }
  }

  Future<void> searchClassRoomList(String searchQuery) async {
    List<ClassRoom> filteredClassRooms = storeList.value
        .where((classRoom) =>
            classRoom.roomid != null &&
            classRoom.roomid!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    classRoomList.value = filteredClassRooms;
    classRoomList.refresh();
  }
  // void updateClassRoomList(String searchQuery) {
  // debounce(
  //   Duration(milliseconds: 500), // 입력 주기를 설정합니다. 500ms로 설정했습니다.
  //   () => getClassRoomList(searchQuery),
  //   (_){},
  // );
  // }
}
