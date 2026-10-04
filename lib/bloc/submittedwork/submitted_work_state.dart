part of 'submitted_work_bloc.dart';

@freezed
abstract class SubmittedHomeworkState with _$SubmittedHomeworkState {
  const factory SubmittedHomeworkState({
    // List.
    required bool isLoading,
    required bool isLoadingMore,
    required bool hasMore,
    required int currentPage,
    required int lastPage,
    required String query,
    required TextEditingController searchController,
    required List<SubmittedHomeworkData> arrSubmittedHomework,

    // Detail and review.
    required bool isLoadingDetail,
    required bool isSubmitting,
    required bool isSubmitted,
    required String selectedStatus,
    required TextEditingController commentController,
    SubmittedHomeworkDetailModel? submittedHomeworkDetailData,

    // Messages.
    String? errorMessage,
    String? detailErrorMessage,
    String? reviewErrorMessage,
    String? successMessage,
  }) = _SubmittedHomeworkState;

  factory SubmittedHomeworkState.initial() {
    return SubmittedHomeworkState(
      isLoading: false,
      isLoadingMore: false,
      hasMore: true,
      currentPage: 0,
      lastPage: 1,
      query: '',
      searchController: TextEditingController(),
      arrSubmittedHomework: [],
      isLoadingDetail: false,
      isSubmitting: false,
      isSubmitted: false,
      selectedStatus: 'Submitted',
      commentController: TextEditingController(),
    );
  }
}