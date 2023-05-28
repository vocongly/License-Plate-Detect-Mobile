import 'package:intl/intl.dart';

class StringHelper {
  static String mapDatetoString({required DateTime date}) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  static String mapTimetoString({required DateTime date}) {
    String formattedDate = DateFormat('hh:mm').format(date);
    return formattedDate;
  }

  static String formatDate({required String date}){
    final y = date.substring(0, 4);
    final m = date.substring(5, 7);
    final d = date.substring(8, 10);
    return "$d/$m/$y";
  }

  static String formatTime({required String time}){
    final h = time.substring(0,2);
    final m = time.substring(3,5);
    final s = time.substring(6,8);
    return "$h:$m:$s";
  }

}
