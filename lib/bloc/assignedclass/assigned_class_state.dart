part of 'assigned_class_bloc.dart';


@freezed
abstract class AssignedClassesState with _$AssignedClassesState {
  const factory AssignedClassesState({
    required bool isLoading,
    required List<AssignedClassData> arrAssignedClasses,
    required TextEditingController searchController,
    @Default('') String query,
    String? errorMessage,
  }) = _AssignedClassesState;

  factory AssignedClassesState.initial() {
    return AssignedClassesState(
      isLoading: false,
      arrAssignedClasses: [],
      searchController: TextEditingController(),
    );
  }
}