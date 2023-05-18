class Incubator {
  int? classnum;
  int? roomnum;
  int? usableLevel;

  Incubator({this.classnum, this.roomnum, this.usableLevel});

  Incubator.fromJson(Map<String, dynamic> json) {
    classnum = json['호'];
    roomnum = json['회의실번호'];
    usableLevel = json['usableLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['호'] = classnum;
    data['회의실번호'] = roomnum;
    data['usableLevel'] = usableLevel;
    return data;
  }
}
