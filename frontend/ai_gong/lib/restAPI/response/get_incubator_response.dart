import 'package:ai_gong/restAPI/models/Incubator.dart';

// Summary:
// IncubatorResponse is used to parse the response from the server
// This class is used in the controller
class IncubatorResponse {
  Incubator? incubator;

  IncubatorResponse({this.incubator});

  IncubatorResponse.fromJson(Map<String, dynamic> json) {
    incubator = Incubator.fromJson(json);
  }
}
