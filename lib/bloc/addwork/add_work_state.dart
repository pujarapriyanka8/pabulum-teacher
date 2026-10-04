part of 'add_work_bloc.dart';

@freezed
abstract class AddWorkState with _$AddWorkState {
  const factory AddWorkState({
    required bool isHomework,
    required bool isLoading,
    required bool isLoadingOptions,
    required bool isPickingAttachment,
    required List<WorkOption> standards,
    required List<WorkOption> divisions,
    required List<WorkOption> subjects,
    required List<WorkOption> lessons,
    required List<WorkOption> topics,
    required TextEditingController titleController,
    required TextEditingController instructionsController,
    required TextEditingController youtubeController,
    @Default(false) bool isSubmitting,
    @Default(false) bool isSubmitted,
    String? errorMessage,
    String? successMessage,
    int? standardId,
    int? divisionId,
    int? subjectId,
    int? lessonId,
    int? topicId,
    DateTime? workDate,
    DateTime? dueDate,
    String? imagePath,
    String? pdfPath,
    String? audioPath,
    String? videoPath,
  }) = _AddWorkState;

  factory AddWorkState.initial({
    required bool isHomework,
  }) {
    return AddWorkState(
      isHomework: isHomework,
      isLoading: false,
      isLoadingOptions: false,
      isPickingAttachment: false,
      standards: [],
      divisions: [],
      subjects: [],
      lessons: [],
      topics: [],
      titleController: TextEditingController(),
      instructionsController: TextEditingController(),
      youtubeController: TextEditingController(),
    );
  }
}