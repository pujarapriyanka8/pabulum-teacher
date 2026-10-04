part of 'homework_bloc.dart';

@freezed
abstract class HomeworkEvent with _$HomeworkEvent {
  const factory HomeworkEvent.onLoadHomeworkData({
    @Default(1) int page,
    @Default('') String search,
  }) = OnLoadHomeworkData;

  const factory HomeworkEvent.onLoadHomeworkDetail({
    required String homeworkId,
  }) = OnLoadHomeworkDetail;

  const factory HomeworkEvent.onDeleteHomework({
    required String homeworkId,
  }) = OnDeleteHomework;

}
