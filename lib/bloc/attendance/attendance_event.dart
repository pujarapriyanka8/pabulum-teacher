part of 'attendance_bloc.dart';

@freezed
abstract class AttendanceEvent with _$AttendanceEvent {
  const factory AttendanceEvent.onLoadAttendanceHistory({
    @Default(1) int page,
    DateTime? date,
  }) = OnLoadAttendanceHistory;

  const factory AttendanceEvent.onLoadAttendanceDetails({
    required String attendanceId,
  }) = OnLoadAttendanceDetails;

  const factory AttendanceEvent.onChangeAttendanceDate({
    required DateTime date,
  }) = OnChangeAttendanceDate;

  const factory AttendanceEvent.onChangeStudentAttendance({
    required String studentId,
    required bool isPresent,
  }) = OnChangeStudentAttendance;

  const factory AttendanceEvent.onMarkAllAttendance({
    required bool isPresent,
    required List<MyStudent> students,
  }) = OnMarkAllAttendance;

  const factory AttendanceEvent.onSubmitAttendance({
    required List<MyStudent> students,
  }) = OnSubmitAttendance;
}
