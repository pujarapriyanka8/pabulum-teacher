part of 'classwork_bloc.dart';

@freezed
abstract class ClassworkState with _$ClassworkState {
  const factory ClassworkState({
    required bool isLoading,
    required bool isLoadingMore,
    required List<ClassworkData> arrClasswork,
    required TextEditingController searchController,
    required int currentPage,
    required bool hasMore,
    @Default('') String query,
    required ClassworkDetailData? classworkDetailData,

  }) = _ClassworkState;

  factory ClassworkState.initial() {
    return ClassworkState(
      isLoading: false,
      isLoadingMore: false,
      arrClasswork: [],
      searchController: TextEditingController(),
      currentPage: 0,
      hasMore: true,
      classworkDetailData: null
    );
  }
}
