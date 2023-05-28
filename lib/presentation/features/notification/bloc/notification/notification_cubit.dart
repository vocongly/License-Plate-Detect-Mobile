import 'package:bloc/bloc.dart';
import 'package:license_plate_detect/core/models/notification_vehicle.dart';
import 'package:license_plate_detect/services/api/app_api.dart';
import 'package:meta/meta.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());


  Future<void> getNotificationByUser() async {
    final notifications = await AppAPI.notificationByUser();
    emit(NotificationSuccess(notifications: notifications));
  }

  void clean(){
    emit(NotificationInitial());
  }
}
