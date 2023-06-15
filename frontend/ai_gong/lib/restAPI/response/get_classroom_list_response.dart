import 'package:ai_gong/restAPI/models/Classroom.dart';

class ClassRoomListResponse {
  List<ClassRoom>? classrooms;

  ClassRoomListResponse({this.classrooms});

  ClassRoomListResponse.fromJson(List<dynamic> jsonList) {
    classrooms = <ClassRoom>[];
    if (jsonList.isNotEmpty) {
      for (var v in jsonList) {
        classrooms!.add(ClassRoom.fromJson(v));
      }
    }
  }
}
