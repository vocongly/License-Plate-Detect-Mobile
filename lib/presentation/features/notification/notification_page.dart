import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:license_plate_detect/core/models/notification_vehicle.dart';

import 'package:license_plate_detect/core/theme/app_color.dart';
import 'package:license_plate_detect/presentation/features/home/presention/HomePage.dart';
import 'package:license_plate_detect/presentation/features/notification/bloc/notification/notification_cubit.dart';
import 'package:license_plate_detect/presentation/features/notification/notification_detail_page.dart';
import 'package:license_plate_detect/presentation/features/notification/widget/notification_item.dart';
import 'package:license_plate_detect/ultis/helper/string_helper.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    GetIt.instance.get<NotificationCubit>().clean();
    GetIt.instance.get<NotificationCubit>().getNotificationByUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông báo',
          style: TextStyle(color: AppColor.primaryColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const MyHomePage();
            }));
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
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: BlocBuilder<NotificationCubit, NotificationState>(
          bloc: GetIt.instance.get<NotificationCubit>(),
          builder: (context, state) {
            if (state is NotificationSuccess) {
              final list = state.notifications;
              if (list.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(child: Text('Không có thông báo nào!')),
                );
              }
              if (list.isNotEmpty) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.only(top: 8),
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final notification = list[index];
                            return ListNotification(notification: notification);
                          }),
                    ),
                  ],
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class ListNotification extends StatelessWidget {
  const ListNotification({
    super.key,
    required this.notification,
  });

  final NotificationVehicle notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 24 + notification.times.length * 96,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringHelper.formatDate(date: notification.date),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor),
          ),
          const SizedBox(
            height: 4,
          ),
          Expanded(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 8),
                itemCount: notification.times.length,
                itemBuilder: (context, index) {
                  final time = notification.times[index];
                  return NotificationItem(
                    notification: notification,
                    time: time,
                    onClicked: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return NotificationDetailPage(
                          notification: notification,
                          time: time,
                        );
                      }));
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
