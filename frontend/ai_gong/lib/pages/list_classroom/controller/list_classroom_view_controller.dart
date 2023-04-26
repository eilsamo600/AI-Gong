import 'package:get/get.dart';

class ListClassRoomViewController extends GetxController {
  static ListClassRoomViewController get instance => Get.find<ListClassRoomViewController>();

  void selectFilter(int index) {
    onTapList.value[index] = !onTapList.value[index];
    onTapList.refresh();
  }

  RxList<bool> onTapList = List.filled(3, false).obs;
}
