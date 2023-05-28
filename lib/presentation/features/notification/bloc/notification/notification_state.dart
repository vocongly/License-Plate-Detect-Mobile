part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationSuccess extends NotificationState{
  final List<NotificationVehicle> notifications;
  NotificationSuccess({required this.notifications});
}

class NotificationError extends NotificationState{}
