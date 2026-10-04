part of 'my_student_bloc.dart';

@freezed
abstract class MyStudentState with _$MyStudentState {
  const factory MyStudentState({
    required bool isLoading,
    required List<MyStudent> arrMyStudents,
    @Default('') String query,
    required TextEditingController studentNameController
  }) = _MyStudentState;

  factory MyStudentState.initial() {
    return MyStudentState(isLoading: false, arrMyStudents: [],studentNameController: TextEditingController());
  }
}
