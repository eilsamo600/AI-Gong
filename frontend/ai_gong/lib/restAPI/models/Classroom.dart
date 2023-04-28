class ClassRoom {
  String? roomid;
  String? department;
  int? floor;
  int? capacity;
  String? scale;
  bool? usable;

  ClassRoom({this.roomid, this.department, this.floor, this.capacity, this.scale, this.usable});

  ClassRoom.fromJson(Map<String, dynamic> json) {
    roomid = json['호'];
    department = json['전공'];
    floor = json['층'];
    capacity = json['수용인원'];
    scale = json['규모'];
    usable = json['usable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['호'] = roomid;
    data['전공'] = department;
    data['층'] = floor;
    data['수용인원'] = capacity;
    data['규모'] = scale;
    data['usable'] = usable;
    return data;
  }
}
