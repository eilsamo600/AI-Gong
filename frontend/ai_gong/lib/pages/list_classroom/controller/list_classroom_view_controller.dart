import 'package:ai_gong/common/service_response.dart';
import 'package:ai_gong/restAPI/api_service.dart';
import 'package:ai_gong/restAPI/response/get_classroom_list_response.dart';
import 'package:get/get.dart';

class ListClassRoomViewController extends GetxController {
  static ListClassRoomViewController get instance => Get.find<ListClassRoomViewController>();

  @override
  void onInit() async {
    super.onInit();
    ApiResponse<ClassRoomListResponse> response = await ApiService.instance.getClassRoomList();
    print(response);
  }

  void selectFilter(int index) {
    onTapList.value[index] = !onTapList.value[index];
    onTapList.refresh();
  }

  RxList<bool> onTapList = List.filled(3, false).obs;
}
