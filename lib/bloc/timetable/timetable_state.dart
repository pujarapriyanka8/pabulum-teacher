part of 'timetable_bloc.dart';

@freezed
abstract class TimetableState with _$TimetableState {
  const factory TimetableState({
    required bool isLoading,
    required List<TimeTableData> arrTimetable,
    required Set<String> expandedDays,
    String? errorMessage,
  }) = _TimetableState;

  factory TimetableState.initial() {
    return const TimetableState(
      isLoading: false,
      arrTimetable: [],
      expandedDays: {},
    );
  }
}