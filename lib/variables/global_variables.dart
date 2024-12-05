import 'package:app_contable/models/user.dart';

class GlobalVariables {
  static User? userLogged;

  static String dateToString(DateTime date) {
    int day = date.day;
    int month = date.month;
    int year = date.year;
    String newDay = '$day';
    String newMonth = '$month';
    if (day < 10) {
      newDay = '0$day';
    }
    if (month < 10) {
      newMonth = '0$month';
    }
    return '$newDay/$newMonth/$year';
  }

  static String timeToString(DateTime date) {
    int hour = date.hour;
    int minute = date.minute;
    String newHour = '$hour';
    String newMinute = '$minute';
    if (hour < 10) {
      newHour = '0$hour';
    }
    if (minute < 10) {
      newMinute = '0$minute';
    }
    return '$newHour:$newMinute';
  }
}
