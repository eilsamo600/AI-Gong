import 'package:ai_gong/restAPI/models/Incubator.dart';

class IncubatorResponse {
  Incubator? incubator;

  IncubatorResponse({this.incubator});

  IncubatorResponse.fromJson(Map<String, dynamic> json) {
    incubator = Incubator.fromJson(json);
  }
}
