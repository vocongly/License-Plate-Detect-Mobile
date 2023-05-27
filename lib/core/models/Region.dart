// ignore_for_file: file_names

class Region {
  String? sId;
  String? region;
  String? type;
  Coordinate? coordinate;
  List<Cameras>? cameras;

  Region({this.sId, this.region, this.type, this.coordinate, this.cameras});

  Region.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    region = json['region'];
    type = json['type'];
    coordinate = json['coordinate'] != null
        ? Coordinate.fromJson(json['coordinate'])
        : null;
    if (json['cameras'] != null) {
      cameras = <Cameras>[];
      json['cameras'].forEach((v) {
        cameras!.add(Cameras.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['region'] = region;
    data['type'] = type;
    if (coordinate != null) {
      data['coordinate'] = coordinate!.toJson();
    }
    if (cameras != null) {
      data['cameras'] = cameras!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coordinate {
  String? longitude;
  String? latitude;

  Coordinate({this.longitude, this.latitude});

  Coordinate.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}

class Cameras {
  String? name;
  String? rtspUrl;
  String? type;

  Cameras({this.name, this.rtspUrl, this.type});

  Cameras.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rtspUrl = json['rtsp_url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['rtsp_url'] = rtspUrl;
    data['type'] = type;
    return data;
  }
}
