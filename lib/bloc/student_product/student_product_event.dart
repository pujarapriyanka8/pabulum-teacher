part of 'student_product_bloc.dart';

@freezed
abstract class StudentProductsEvent with _$StudentProductsEvent {
  const factory StudentProductsEvent.onLoadStudentProducts({
    @Default(1) int page,
  }) = OnLoadStudentProducts;

  const factory StudentProductsEvent.onUpdateProductStatus({
    required num requestId,
    required String status,
  }) = OnUpdateProductStatus;
}
