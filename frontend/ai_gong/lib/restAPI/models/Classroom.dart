class ClassRoom {
  //attributes of clasroom table
  String? roomid;
  String? department;
  int? floor;
  int? capacity;
  String? scale;
  int? usableLevel;
  Map? currentLecture;
  Map? lectures;

  ClassRoom(
      {this.roomid,
      this.department,
      this.floor,
      this.capacity,
      this.scale,
      this.usableLevel,
      this.currentLecture,
      this.lectures});

  // JSON deserialization constructor
  ClassRoom.fromJson(Map<String, dynamic> json) {
    roomid = json['호'];
    department = json['전공'];
    floor = json['층'];
    capacity = json['수용인원'];
    scale = json['규모'];
    usableLevel = json['usableLevel'];
    currentLecture = json['currentLecture'];
    lectures = json['강의목록'];
  }

  // JSON serialization method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['호'] = roomid;
    data['전공'] = department;
    data['층'] = floor;
    data['수용인원'] = capacity;
    data['규모'] = scale;
    data['usableLevel'] = usableLevel;
    data['currentLecture'] = currentLecture;
    data['강의목록'] = lectures;
    return data;
  }
}
