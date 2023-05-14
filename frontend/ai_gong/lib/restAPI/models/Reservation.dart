class Reservation {
  String? email;
  String? number;
  int? time;
  String? date;

  Reservation({this.email, this.number, this.time, this.date});

  Reservation.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    number = json['number'];
    time = json['number'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['number'] = number;
    data['time'] = time;
    data['date'] = date;
    return data;
  }
}
