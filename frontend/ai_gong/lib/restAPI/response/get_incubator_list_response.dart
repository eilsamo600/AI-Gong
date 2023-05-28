import 'package:ai_gong/restAPI/models/Incubator.dart';

class IncubatorListResponse {
  List<Incubator>? incubators;

  IncubatorListResponse({this.incubators});

  IncubatorListResponse.fromJson(List<dynamic> jsonList) {
    if (jsonList.isNotEmpty) {
      incubators = <Incubator>[];
      for (var v in jsonList) {
        print(v);
        incubators!.add(Incubator.fromJson(v));
        print(incubators);
      }
    }
  }
}
