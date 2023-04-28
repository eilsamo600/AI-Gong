import 'package:ai_gong/restAPI/models/Classroom.dart';

class ClassRoomListResponse {
  List<ClassRoom>? classrooms;

  ClassRoomListResponse({this.classrooms});

  ClassRoomListResponse.fromJson(List<dynamic> jsonList) {
    if (jsonList.isNotEmpty) {
      classrooms = <ClassRoom>[];
      for (var v in jsonList) {
        classrooms!.add(ClassRoom.fromJson(v));
      }
    }
  }
}
