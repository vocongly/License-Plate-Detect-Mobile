import 'package:flutter/material.dart';
import 'package:license_plate_detect/core/models/notification_vehicle.dart';
import 'package:license_plate_detect/core/theme/app_color.dart';
import 'package:license_plate_detect/core/theme/app_data.dart';
import 'package:license_plate_detect/ultis/helper/string_helper.dart';

class NotificationItem extends StatelessWidget {
  final NotificationVehicle notification;
  final Times time;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.primaryColor, width: 1)),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
                border: Border.all(color: AppColor.primaryColor, width: 1)),
            child: notification.vehicleType == "motorcycle"
                ? Image.asset(
                    AppData.icMotobike,
                    width: 32,
                  )
                : Image.asset(
                    AppData.icCar,
                    width: 32,
                  )),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Xe có biển số ",
                    style: Theme.of(context).textTheme.titleMedium),
                TextSpan(
                  text: notification.plate,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.red),
                ),
                TextSpan(
                  text: time.turnType == "in" ? " vào " : " ra ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextSpan(
                  text: notification.region,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ])),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Thời gian: " + StringHelper.formatTime(time: time.time),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
