class Reservation {
  String? email;
  String? number;
  List? time;
  String? date;
  int? people;

  Reservation({this.email, this.number, this.time, this.date, this.people});

  Reservation.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    number = json['number'];
    time = json['time'];
    date = json['date'];
    people = json['people'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['number'] = number;
    data['time'] = time;
    data['date'] = date;
    data['people'] = people;
    return data;
  }
}
