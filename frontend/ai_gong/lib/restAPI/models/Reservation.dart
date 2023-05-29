class Reservation {
  String? email;
  String? number;
  List<int>? time;
  String? date;
  int? people;
  int? state;
  String? id;
  int? timestamp;

  Reservation({this.email, this.number, this.time, this.date, this.people, this.state});

  Reservation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    number = json['number'];
    time = json['time'].cast<int>();
    date = json['date'];
    people = json['people'];
    state = json['state'];
    if (json['_id'] != null) {
      timestamp = json['_id']['timestamp'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['email'] = email;
    data['number'] = number;
    data['time'] = time;
    data['date'] = date;
    data['people'] = people;
    data['state'] = state;
    data['id'] = id;
    return data;
  }
}
