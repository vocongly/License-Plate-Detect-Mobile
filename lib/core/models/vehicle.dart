class Vehicle {
  String? username;
  String? plate;
  Information? information;
  String? turn;

  Vehicle({this.username, this.plate, this.information, this.turn});

  Vehicle.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    plate = json['plate'];
    information = json['information'] != null
        ? Information.fromJson(json['information'])
        : null;
    turn = json['turn'];
  }

}

class Information {
  String? date;
  String? time;

  Information({this.date, this.time});

  Information.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
  }

}

