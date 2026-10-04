import 'dart:math';
import 'dart:ui';

import 'package:pabulum_teacher/model/login_response.dart';

class Constants{
  static Constants shared = Constants();
  static const String loginUserData = 'loginUserData';
  static const String isLogin = 'isLogin';

   UserData? userLoginData;
  // DashboardModel? profileData;

}
enum DateFormats {
  hhMMa("hh:mm a"),
  hhmmss("HH:mm:ss"),
  hhmm("HH:mm"),
  ddEEE("dd\nEEE"),
  mmmDdYYYY("MMMM dd, yyyy"),
  mmDdYYYY("MM-dd-yyyy"),
  ddMmYYYY("dd-MM-yyyy"),
  yyyyMMDD("yyyy-MM-dd"),
  ddMMYYYYhhmmEEEE("dd-MM-yyyy hh:mm a"),
  ddMMYYYYhhmm("MMMM dd, yyyy hh:mm a");


  final String value;
  const DateFormats(this.value);
}
enum TextFieldTypes { text, email, password, number, multiline }

enum ClassworkMediaType {
  image,
  video,
  youtube,
  audio,
}

enum TeacherTool {
  attendance,
  students,
  assignments,
  submittedHomework,
  classwork,
  assignedClasses,
  timetable,
  studentOrders,
}
final random = Random();

Color getRandomColor() {
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}