import 'package:ai_gong/restAPI/models/Classroom.dart';

// Summary:
// ClassRoomListResponse is used to parse the response from the server
// This class is used in the controller
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
