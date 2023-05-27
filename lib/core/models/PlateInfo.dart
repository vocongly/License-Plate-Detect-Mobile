// ignore_for_file: file_names

class PlateInfo {
  String? plate;
  Coordinate? coordinate;

  PlateInfo({this.plate, this.coordinate});

  PlateInfo.fromJson(Map<String, dynamic> json) {
    plate = json['plate'];
    coordinate = json['coordinate'] != null
        ? Coordinate.fromJson(json['coordinate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plate'] = plate;
    if (coordinate != null) {
      data['coordinate'] = coordinate!.toJson();
    }
    return data;
  }
}

class Coordinate {
  int? x0;
  int? y0;
  int? x1;
  int? y1;

  Coordinate({this.x0, this.y0, this.x1, this.y1});

  Coordinate.fromJson(Map<String, dynamic> json) {
    x0 = json['x0'];
    y0 = json['y0'];
    x1 = json['x1'];
    y1 = json['y1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x0'] = x0;
    data['y0'] = y0;
    data['x1'] = x1;
    data['y1'] = y1;
    return data;
  }
}
