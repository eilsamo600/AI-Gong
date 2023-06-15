import 'package:ai_gong/restAPI/models/Incubator.dart';

// Summary:
// IncubatorListResponse is used to parse the response from the server
// This class is used in the controller
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
