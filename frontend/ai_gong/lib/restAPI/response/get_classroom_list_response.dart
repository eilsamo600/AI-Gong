import 'package:ai_gong/restAPI/models/Classroom.dart';

class ClassRoomListResponse {
  List<ClassRoom>? classrooms;

  ClassRoomListResponse({this.classrooms});

  ClassRoomListResponse.fromJson(Map<String, dynamic> json) {
    if (json['classrooms'] != null) {
      classrooms = <ClassRoom>[];
      json['classrooms'].forEach((v) {
        classrooms!.add(ClassRoom.fromJson(v));
      });
    }
  }
}
