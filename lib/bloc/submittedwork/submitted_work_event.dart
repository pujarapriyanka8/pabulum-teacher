part of 'submitted_work_bloc.dart';

@freezed
abstract class SubmittedHomeworkEvent with _$SubmittedHomeworkEvent {
  const factory SubmittedHomeworkEvent.onLoadSubmittedHomework({
    @Default(1) int page,
    @Default('') String query,
  }) = OnLoadSubmittedHomework;



  const factory SubmittedHomeworkEvent.onLoadSubmittedHomeworkDetail({
    required int submittedHomeworkId,
  }) = OnLoadSubmittedHomeworkDetail;

  const factory SubmittedHomeworkEvent.onSelectReviewStatus({
    required String status,
  }) = OnSelectReviewStatus;

  const factory SubmittedHomeworkEvent.onSubmitReview() = OnSubmitReview;
}
