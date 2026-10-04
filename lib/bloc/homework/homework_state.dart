part of 'homework_bloc.dart';

@freezed
abstract class HomeworkState with _$HomeworkState {
  const factory HomeworkState({
    required bool isLoading,
    required bool isLoadingMore,
    required List<HomeWorkData> arrHomeWork,
    required int currentPage,
    required int lastPage,
    required bool hasMore,
    required String search,
    required TextEditingController searchController,
    required HomeworkDetailData? homeworkDetailData,


  }) = _HomeworkState;

  factory HomeworkState.initial() {
    return  HomeworkState(
      isLoading: false,
      isLoadingMore: false,
      arrHomeWork: [],
      currentPage: 0,
      lastPage: 1,
      hasMore: true,
      search: '',
      searchController: TextEditingController(),
      homeworkDetailData: null
    );
  }
}
