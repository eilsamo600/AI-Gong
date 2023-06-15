import 'package:ai_gong/restAPI/models/Classroom.dart';

// Summary:
// ClassRoomResponse is used to parse the response from the server
// This class is used in the controller
class ClassRoomResponse {
  ClassRoom? classroom;

  ClassRoomResponse({this.classroom});

  ClassRoomResponse.fromJson(Map<String, dynamic> json) {
    classroom = ClassRoom.fromJson(json);
  }
}
