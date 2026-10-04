import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pabulum_teacher/model/student_product_model.dart';
import 'package:pabulum_teacher/network/api_service.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/utils.dart';

part 'student_product_event.dart';
part 'student_product_state.dart';
part 'student_product_bloc.freezed.dart';

class StudentProductsBloc
    extends Bloc<StudentProductsEvent, StudentProductsState> {
  final ApiService apiService = ApiService();

  StudentProductsBloc() : super(StudentProductsState.initial()) {
    on<OnLoadStudentProducts>(onLoadStudentProducts);
    on<OnUpdateProductStatus>(onUpdateProductStatus);

  }


  Future<void> onUpdateProductStatus(
      OnUpdateProductStatus event,
      Emitter<StudentProductsState> emit,
      ) async {
    if (state.isLoading ||
        state.isLoadingMore ) {
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));

      final response = await apiService.postRequest(
        '${AppEndPoints.studentProductStatus}/${event.requestId}',
         {
          'status': event.status,
        },
      );

      if (emit.isDone) return;

      if (response.statusCode == 200) {
        final result = response.data;

        emit(state.copyWith(isLoading: false));

        if (result['success'] == true) {
          Utils.showToast(result['message'], true);

          await onLoadStudentProducts(
            const OnLoadStudentProducts(page: 1),
            emit,
          );
        } else {
          Utils.showToast(result['message'], false);
        }
      } else {
        emit(state.copyWith(isLoading: false));
        Utils.showToast(response.statusMessage, false);
      }
    } catch (e) {
      debugPrint(e.toString());

      if (emit.isDone) return;

      emit(state.copyWith(isLoading: false));
      Utils.showToast(e, false);
    }
  }


  Future<void> onLoadStudentProducts(
      OnLoadStudentProducts event,
      Emitter<StudentProductsState> emit,
      ) async {
    if (state.isLoading || state.isLoadingMore) return;
    if (event.page < 1) return;

    final isFirstPage = event.page == 1;

    if (!isFirstPage) {
      if (!state.hasMore ||
          state.currentPage == 0 ||
          event.page != state.currentPage + 1) {
        return;
      }
    }

    try {
      emit(
        state.copyWith(
          isLoading: isFirstPage,
          isLoadingMore: !isFirstPage,
        ),
      );

      final endpoint = Uri.parse(AppEndPoints.studentProducts);

      final url = endpoint.replace(
        queryParameters: {
          ...endpoint.queryParameters,
          'page': event.page.toString(),
        },
      ).toString();

      final response = await apiService.getRequest(url);

      if (emit.isDone) return;

      if (response.statusCode == 200) {
        final result = StudentProductModel.fromJson(response.data);

        if (result.success == true) {
          final pageItems = result.data ?? <StudentProductData>[];

          final combinedItems = isFirstPage
              ? pageItems
              : [
            ...state.arrStudentProducts,
            ...pageItems,
          ];

          // Prevent duplicate cards when pages overlap.
          final seenIds = <num>{};
          final uniqueItems = <StudentProductData>[];

          for (final item in combinedItems) {
            final id = item.id;

            if (id == null || seenIds.add(id)) {
              uniqueItems.add(item);
            }
          }

          final hasMore = result.lastPage != null
              ? event.page < result.lastPage!
              : pageItems.isNotEmpty;

          emit(
            state.copyWith(
              isLoading: false,
              isLoadingMore: false,
              arrStudentProducts: uniqueItems,
              currentPage: event.page,
              hasMore: hasMore,
            ),
          );
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              isLoadingMore: false,
            ),
          );

          Utils.showToast(
            result.message ?? 'Unable to load product requests.',
            false,
          );
        }
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            isLoadingMore: false,
          ),
        );

        Utils.showToast(
          response.statusMessage ?? 'Unable to load product requests.',
          false,
        );
      }
    } catch (e) {
      debugPrint(e.toString());

      if (emit.isDone) return;

      emit(
        state.copyWith(
          isLoading: false,
          isLoadingMore: false,
        ),
      );

      Utils.showToast(e, false);
    }
  }
}
