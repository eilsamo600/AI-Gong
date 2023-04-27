class ClassRoom {
  String? roomid;
  String? department;
  int? floor;
  int? capacity;
  String? scale;
  bool? usable;

  ClassRoom({this.roomid, this.department, this.floor, this.capacity, this.scale, this.usable});

  ClassRoom.fromJson(Map<String, dynamic> json) {
    roomid = json['roomid'];
    department = json['department'];
    floor = json['floor'];
    capacity = json['capacity'];
    scale = json['scale'];
    usable = json['usable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roomid'] = roomid;
    data['department'] = department;
    data['floor'] = floor;
    data['capacity'] = capacity;
    data['scale'] = scale;
    data['usable'] = usable;
    return data;
  }
}
