class NotificationVehicle {
  late String id;
  late String plate;
  late String vehicleType;
  late String region;
  late String date;
  late List<Times> times;

  NotificationVehicle.fromJson(Map<String, dynamic> json){
    id = json["_id"];
    plate = json["vehicle"]["plate"];
    vehicleType = json["vehicle"]["type"];
    region = json["region"]["region"];
    date= json["in_and_out_time"]["date"];
    times=[];
    json["in_and_out_time"]["times"].forEach((v){
      times.add(Times.fromJson(v));
    });
  }

}

class Times {
  late String time;
  late String turnType;
  String? vehicleImage;
  String? faceImage;

  Times.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    turnType = json["type"];
    if (json["vehicle_img_base64"] != null) {
      vehicleImage = json["vehicle_img_base64"];
    }else{
      vehicleImage = null;
    }
    if (json["face_img_base64"] != null) {
      faceImage = json["face_img_base64"];
    }else{
      faceImage = null;
    }
  }
}
