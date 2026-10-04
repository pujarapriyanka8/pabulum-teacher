part of 'student_product_bloc.dart';

@freezed
abstract class StudentProductsState with _$StudentProductsState {
  const factory StudentProductsState({
    required bool isLoading,
    required bool isLoadingMore,
    required List<StudentProductData> arrStudentProducts,
    required int currentPage,
    required bool hasMore,
  }) = _StudentProductsState;

  factory StudentProductsState.initial() {
    return const StudentProductsState(
      isLoading: false,
      isLoadingMore: false,
      arrStudentProducts: [],
      currentPage: 0,
      hasMore: true,
    );
  }
}
