part of 'my_student_bloc.dart';

@freezed
abstract  class MyStudentEvent with _$MyStudentEvent {
  const factory MyStudentEvent.onLoadMyStudents({
    @Default('') String query,
    @Default(false) bool debounce,
  }) = OnLoadMyStudents;
}
