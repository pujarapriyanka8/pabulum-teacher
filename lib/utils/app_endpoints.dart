class AppEndPoints{
  static String baseUrl = 'https://pabulum-backend.solisgentech.in/api/v1';
  static String login = '$baseUrl/teacher/login';
  static String dashboard = '$baseUrl/teacher/dashboard';
  static String attendanceSave = '$baseUrl/teacher/attendance-save';
  static String myStudent = '$baseUrl/teacher/my-students?q=';
  static String attendanceHistory = '$baseUrl/teacher/attendance';
  static String attendanceDetail = '$baseUrl/teacher/attendance-details';
  static String homeworks = '$baseUrl/teacher/homeworks';
  static String homeworkDetail = '$baseUrl/teacher/homeworks';
  static String addHomework = '$baseUrl/teacher/add-homework';
  static String addClasswork = '$baseUrl/teacher/add-classwork';
  static String profile = '$baseUrl/teacher/profile';
  static String studentProducts = '$baseUrl/teacher/student-products';
  static String myAssignedClass = '$baseUrl/teacher/my-assigned-classes';
  static String submittedHomeWork = '$baseUrl/teacher/submitted-homeworks';
  static String deleteHomeWork = '$baseUrl/teacher/delete-homework';
  static String classworkDetail = '$baseUrl/teacher/classworks';
  static String submittedHomeWorkDetail = '$baseUrl/teacher/submitted-homework-details';
  static String classworksList = '$baseUrl/teacher/classworks';
  static String submittedHomeworkCheck = '$baseUrl/teacher/submitted-homework-check';
  static String deleteClasswork = '$baseUrl/teacher/delete-classwork';
  static String studentProductStatus = '$baseUrl/teacher/student-products-update-status';
  static String sendMessage = '$baseUrl/teacher/send-message';
  static String chatDetail = '$baseUrl/teacher/chats';
  static String chatList  = '$baseUrl/teacher/chats';
  static String timeTable  = '$baseUrl/teacher/timetable';
  static String standards = '$baseUrl/teacher/standards';
  static String divisions = '$baseUrl/teacher/divisions';
  static String subjects = '$baseUrl/teacher/subjects';
  static String lessons = '$baseUrl/teacher/lessons';
  static String topics = '$baseUrl/teacher/topics';
  static String allStudents = '$baseUrl/teacher/all-students';

  static String getPrivacyPolicyLink = 'https://pabulum.solisgentech.in/privacy-policy/';
  static String getTermLink = 'https://pabulum.solisgentech.in/terms-and-conditions/';
  static String getAboutLink = 'https://pabulum.solisgentech.in/about-us/';


}