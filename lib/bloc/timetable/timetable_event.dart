part of 'timetable_bloc.dart';

@freezed
abstract class TimetableEvent with _$TimetableEvent {
  const factory TimetableEvent.onLoadTimetable() = OnLoadTimetable;

  const factory TimetableEvent.onToggleDay({
    required String day,
  }) = OnToggleDay;
}