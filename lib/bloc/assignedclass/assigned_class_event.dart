part of 'assigned_class_bloc.dart';

@freezed
abstract class AssignedClassesEvent with _$AssignedClassesEvent {
  const factory AssignedClassesEvent.onLoadAssignedClasses() =
  OnLoadAssignedClasses;

  const factory AssignedClassesEvent.onSearchAssignedClasses({
    @Default('') String query,
  }) = OnSearchAssignedClasses;

  const factory AssignedClassesEvent.onClearSearch() =
  OnClearAssignedClassesSearch;
}