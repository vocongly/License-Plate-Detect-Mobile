import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/models/notification_vehicle.dart';
import 'package:license_plate_detect/core/theme/app_color.dart';
import 'package:license_plate_detect/ultis/helper/string_helper.dart';

class NotificationDetailPage extends StatefulWidget {
  final NotificationVehicle notification;
  final Times time;

  const NotificationDetailPage(
      {super.key, required this.notification, required this.time});

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết thông báo',
          style: TextStyle(color: AppColor.primaryColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
        child: ListView(children: [
          inforWidget(pre: "Biển số xe", suf: widget.notification.plate),
          inforWidget(pre: "Bãi đỗ xe", suf: widget.notification.region),
          inforWidget(pre: "Lượt", suf: widget.time.turnType == "in" ? "vào" : "ra"),
          inforWidget(pre: "Loại xe", suf: widget.notification.vehicleType == "motorcycle" ? "xe máy" : "xe hơi"),
          inforWidget(
              pre: "Ngày",
              suf: StringHelper.formatDate(date: widget.notification.date)),
          inforWidget(
              pre: "Thời gian",
              suf: StringHelper.formatTime(time: widget.time.time)),
          titleAndImage(tilte: "Hình ảnh biển số xe", imgBase64: widget.time.vehicleImage),
          titleAndImage(tilte: "Hình ảnh chủ xe", imgBase64: widget.time.faceImage),
        ]),
      ),
    );
  }

  Widget titleAndImage({required String tilte, required String? imgBase64}) {
    return Padding(
      padding: const EdgeInsets.only(top :8.0),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$tilte:",style: const TextStyle(fontSize: 20),),
              if (imgBase64 != null) 
                imageBase64(imgBase64: imgBase64)
            ],
          ),
    );
  }

  Widget imageBase64({required String imgBase64}) {
    Uint8List bytes = base64Decode(imgBase64);
    Widget imageWidget = Center(child: Image.memory(bytes,height: 300,));
    return imageWidget;
  }

  Widget inforWidget({required String pre, required String suf}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(
                "$pre:",
                style: const TextStyle(fontSize: 20),
              )),
          Expanded(
              flex: 3, child: Text(suf, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
