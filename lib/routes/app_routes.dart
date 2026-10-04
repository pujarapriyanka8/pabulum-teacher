import 'package:flutter/material.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/screen/add_classwork_screen.dart';
import 'package:pabulum_teacher/screen/add_homework_screen.dart';
import 'package:pabulum_teacher/screen/assigned_class_screen.dart';
import 'package:pabulum_teacher/screen/attendance_detail_screen.dart';
import 'package:pabulum_teacher/screen/attendance_history_screen.dart';
import 'package:pabulum_teacher/screen/chat_detail_screen.dart';
import 'package:pabulum_teacher/screen/classwork_detail_screen.dart';
import 'package:pabulum_teacher/screen/classwork_screen.dart';
import 'package:pabulum_teacher/screen/homework_detail_screen.dart';
import 'package:pabulum_teacher/screen/homework_screen.dart';
import 'package:pabulum_teacher/screen/login_screen.dart';
import 'package:pabulum_teacher/screen/new_chat_screen.dart';
import 'package:pabulum_teacher/screen/splash_screen.dart';
import 'package:pabulum_teacher/screen/student_product_screen.dart';
import 'package:pabulum_teacher/screen/student_screen.dart';
import 'package:pabulum_teacher/screen/submitted_homework_detail_screen.dart';
import 'package:pabulum_teacher/screen/submitted_work_screen.dart';
import 'package:pabulum_teacher/screen/take_attendance_screen.dart';
import 'package:pabulum_teacher/screen/timetable_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      RouteName.splashScreen: (final BuildContext context) => SplashScreen(),
      RouteName.loginScreen: (final BuildContext context) => LoginScreen(),
      RouteName.myStudentScreen: (final BuildContext context) =>
          StudentsScreen(),
      RouteName.attendanceHistoryScreen: (final BuildContext context) =>
          AttendanceHistoryScreen(),
      RouteName.attendanceDetailScreen: (final BuildContext context) =>
          AttendanceDetailsScreen(),
      RouteName.takeAttendanceScreen: (final BuildContext context) =>
          TakeAttendanceScreen(),
      RouteName.homeworkScreen: (final BuildContext context) =>
          HomeworkScreen(),
      RouteName.timetableScreen: (final BuildContext context) =>
          TimetableScreen(),
      RouteName.assignedClassScreen: (final BuildContext context) =>
          AssignedClassesScreen(),
      RouteName.studentProduct: (final BuildContext context) =>
          StudentProductsScreen(),
      RouteName.classworkScreen: (final BuildContext context) =>
          ClassworkScreen(),
      RouteName.classworkDetailScreen: (final BuildContext context) =>
          ClassworkDetailScreen(),
      RouteName.homeworkDetailScreen: (final BuildContext context) =>
          HomeworkDetailScreen(),
      RouteName.addHomeworkScreen: (final BuildContext context) =>
          AddHomeworkScreen(),
      RouteName.addClassworkScreen: (final BuildContext context) =>
          AddClassworkScreen(),
      RouteName.submittedHomeworkScreen: (final BuildContext context) =>
          SubmittedHomeworkScreen(),
      RouteName.submittedHomeworkDetailScreen: (final BuildContext context) =>
          SubmittedHomeworkDetailScreen(),
      RouteName.newChatScreen: (final BuildContext context) =>
          NewChatScreen(),
      RouteName.chatDetailScreen: (final BuildContext context) =>
          ChatDetailScreen(),
    };
  }
}
