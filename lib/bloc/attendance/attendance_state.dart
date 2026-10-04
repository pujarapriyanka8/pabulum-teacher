part of 'attendance_bloc.dart';

@freezed
abstract class AttendanceState with _$AttendanceState {
  const factory AttendanceState({
    required bool isLoading,
    required bool isLoadingMore,
    required bool isSubmitting,
    required bool isSubmitted,
    required List<AttendanceHistory> arrAttendanceHistory,
    required AttendanceDetailData? attendanceDetailData,
    required Map<String, bool> attendanceStatus,
    required DateTime attendanceDate,
    required int currentPage,
    required bool hasMore,
    DateTime? filterDate,
  }) = _AttendanceState;

  factory AttendanceState.initial() {
    return AttendanceState(
      isLoading: false,
      isLoadingMore: false,
      isSubmitting: false,
      isSubmitted: false,
      arrAttendanceHistory: [],
      attendanceDetailData: null,
      attendanceStatus: {},
      attendanceDate: DateUtils.dateOnly(DateTime.now()),
      currentPage: 0,
      hasMore: true,
    );
  }
}


