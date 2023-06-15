class Incubator {
  //attributes of clasroom table
  int? floar;
  String? classNum;
  int? roomNum;
  String? capacity;
  int? usableLevel;

  Incubator(
      {this.floar,
      this.classNum,
      this.roomNum,
      this.capacity,
      this.usableLevel});

  // JSON serialization method
  Incubator.fromJson(Map<String, dynamic> json) {
    floar = json['층'];
    classNum = json['호'];
    roomNum = json['번호'];
    capacity = json['수용인원'];
    usableLevel = json['usableLevel'];
  }

  // JSON serialization method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['층'] = floar;
    data['호'] = classNum;
    data['번호'] = roomNum;
    data['수용인원'] = capacity;
    data['usableLevel'] = usableLevel;

    return data;
  }
}
