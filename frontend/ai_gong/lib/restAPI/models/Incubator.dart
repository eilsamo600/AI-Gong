class Incubator {
  String? roomid;
  int? floor;
  int? roomnum;
  int? usableLevel;

  Incubator({this.roomid, this.floor, this.roomnum, this.usableLevel});

  Incubator.fromJson(Map<String, dynamic> json) {
    //roomid = json['호'];
    //floor = json['층'];
    //roomnum = json['강의실'];
    //usableLevel = json['usableLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['호'] = roomid;
    data['층'] = floor;
    data['강의실'] = roomnum;
    data['usableLevel'] = usableLevel;
    return data;
  }
}
