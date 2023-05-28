import 'package:get_it/get_it.dart';
import 'package:license_plate_detect/presentation/features/notification/bloc/notification/notification_cubit.dart';


Future<void> configureDependencies() async {
  GetIt.instance.registerLazySingleton<NotificationCubit>(() => NotificationCubit());
}
