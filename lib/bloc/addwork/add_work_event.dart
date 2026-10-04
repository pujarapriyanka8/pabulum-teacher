part of 'add_work_bloc.dart';

enum WorkAttachmentType {
  image,
  pdf,
  audio,

}

@freezed
abstract class AddWorkEvent with _$AddWorkEvent {
  const factory AddWorkEvent.onLoadStandards() = OnLoadStandards;

  const factory AddWorkEvent.onSelectStandard({
    required int standardId,
  }) = OnSelectStandard;

  const factory AddWorkEvent.onSelectDivision({
    required int divisionId,
  }) = OnSelectDivision;

  const factory AddWorkEvent.onSelectSubject({
    required int subjectId,
  }) = OnSelectSubject;

  const factory AddWorkEvent.onSelectLesson({
    required int lessonId,
  }) = OnSelectLesson;

  const factory AddWorkEvent.onSelectTopic({
    required int topicId,
  }) = OnSelectTopic;

  const factory AddWorkEvent.onSelectWorkDate({
    required DateTime date,
  }) = OnSelectWorkDate;

  const factory AddWorkEvent.onSelectDueDate({
    required DateTime date,
  }) = OnSelectDueDate;

  const factory AddWorkEvent.onPickAttachment({
    required WorkAttachmentType type,
  }) = OnPickAttachment;

  const factory AddWorkEvent.onRemoveAttachment({
    required WorkAttachmentType type,
  }) = OnRemoveAttachment;


  const factory AddWorkEvent.onSubmitHomework() = OnSubmitHomework;

  const factory AddWorkEvent.onSubmitClasswork() = OnSubmitClasswork;
}