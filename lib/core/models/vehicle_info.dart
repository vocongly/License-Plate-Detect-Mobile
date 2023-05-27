class VehicleInfo {
  String? sId;
  String? plate;
  String? userId;
  String? type;

  VehicleInfo({this.sId, this.plate, this.userId, this.type});

  VehicleInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    plate = json['plate'];
    userId = json['user_id'];
    type = json['type'];
  }

}
