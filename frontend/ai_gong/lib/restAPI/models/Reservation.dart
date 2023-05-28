class Reservation {
  String? email;
  String? number;
  List<dynamic>? time;
  String? date;
  int? people;
  int? state;

  Reservation(
      {this.email, this.number, this.time, this.date, this.people, this.state});

  Reservation.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    number = json['number'];
    time = json['time'];
    date = json['date'];
    people = json['people'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['number'] = number;
    data['time'] = time;
    data['date'] = date;
    data['people'] = people;
    data['state'] = state;
    return data;
  }
}
