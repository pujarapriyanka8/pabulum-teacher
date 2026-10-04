import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pabulum_teacher/model/classwork_detail_model.dart';
import 'package:pabulum_teacher/model/classwork_model.dart';
import 'package:pabulum_teacher/network/api_service.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/utils.dart';

part 'classwork_event.dart';
part 'classwork_state.dart';
part 'classwork_bloc.freezed.dart';

class ClassworkBloc extends Bloc<ClassworkEvent, ClassworkState> {
  final ApiService apiService = ApiService();

  ClassworkBloc() : super(ClassworkState.initial()) {
    on<OnLoadClasswork>(onLoadClasswork);
    on<OnLoadClassworkDetail>(onLoadClassworkDetail);
    on<OnDeleteClasswork>(onDeleteClasswork);

  }


  Future<void> onLoadClassworkDetail(
      OnLoadClassworkDetail event,
      Emitter<ClassworkState> emit,
      ) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          classworkDetailData: null,
        ),
      );

      final response = await apiService.getRequest(
        '${AppEndPoints.classworkDetail}/${event.classworkId}',
      );

      if (emit.isDone) return;

      if (response.statusCode == 200) {
        ClassworkDetailModel result = ClassworkDetailModel.fromJson(response.data);

        if (result.success == true) {
          emit(
            state.copyWith(
              isLoading: false,
              classworkDetailData: result.data,
            ),
          );
        } else {
          emit(state.copyWith(isLoading: false));
          Utils.showToast(result.message, false);
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

  Future<void> onLoadClasswork(
      OnLoadClasswork event,
      Emitter<ClassworkState> emit,
      ) async {
    if (event.page < 1) return;

    final query = event.query.trim();
    final isFirstPage = event.page == 1;

    // Prevent duplicate pagination requests.
    if (!isFirstPage) {
      if (state.isLoading ||
          state.isLoadingMore ||
          !state.hasMore ||
          state.currentPage == 0 ||
          event.page != state.currentPage + 1 ||
          query != state.query) {
        return;
      }
    }

    try {
      emit(
        state.copyWith(
          isLoading: isFirstPage,
          isLoadingMore: !isFirstPage,
          query: query,
          arrClasswork: isFirstPage ? [] : state.arrClasswork,
          currentPage: isFirstPage ? 0 : state.currentPage,
          hasMore: isFirstPage ? true : state.hasMore,
        ),
      );

      final endpoint = Uri.parse(AppEndPoints.classworksList);

      final url = endpoint.replace(
        queryParameters: {
          ...endpoint.queryParameters,
          'page': event.page.toString(),
          'q': query,
        },
      ).toString();

      final response = await apiService.getRequest(url);

      if (emit.isDone) return;

      // Ignore results belonging to a previous search.
      if (query != state.query) return;

      if (response.statusCode == 200) {
        final result = ClassworkModel.fromJson(response.data);

        if (result.success == true) {
          final pageItems = result.data ?? <ClassworkData>[];

          emit(
            state.copyWith(
              isLoading: false,
              isLoadingMore: false,
              arrClasswork: isFirstPage
                  ? pageItems
                  : [
                ...state.arrClasswork,
                ...pageItems,
              ],
              currentPage: event.page,
              hasMore: event.page < (result.lastPage ?? event.page),
            ),
          );
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              isLoadingMore: false,
            ),
          );

          Utils.showToast(result.message, false);
        }
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            isLoadingMore: false,
          ),
        );

        Utils.showToast(response.statusMessage, false);
      }
    } catch (e) {
      debugPrint(e.toString());

      if (emit.isDone || query != state.query) return;

      emit(
        state.copyWith(
          isLoading: false,
          isLoadingMore: false,
        ),
      );

      Utils.showToast(e, false);
    }
  }

  Future<void> onDeleteClasswork(
      OnDeleteClasswork event,
      Emitter<ClassworkState> emit,
      ) async {
    if (state.isLoading || state.isLoadingMore) return;

    emit(state.copyWith(isLoading: true));

    try {
      final response = await apiService.postRequest(
        '${AppEndPoints.deleteClasswork}/${event.classworkId}',
        {},
      );

      if (emit.isDone) return;

      if (response.statusCode == 200) {
        final body = Map<String, dynamic>.from(response.data as Map);

        if (body['success'] == true) {
          final message = body['message']?.toString() ??
              'Classwork deleted successfully.';

          emit(
            state.copyWith(
              isLoading: false,
              arrClasswork: state.arrClasswork
                  .where(
                    (classwork) => classwork.id != event.classworkId,
              )
                  .toList(),
            ),
          );

          Utils.showToast(message, true);

          // Refresh the list with the current search query.
          add(
            ClassworkEvent.onLoadClasswork(
              page: 1,
              query: state.query,
            ),
          );
        } else {
          emit(state.copyWith(isLoading: false));

          Utils.showToast(
            body['message']?.toString() ??
                'Unable to delete classwork.',
            false,
          );
        }
      } else {
        emit(state.copyWith(isLoading: false));

        final body = response.data;

        final message = body is Map
            ? body['message']?.toString() ??
            response.statusMessage ??
            'Unable to delete classwork.'
            : response.statusMessage ?? 'Unable to delete classwork.';

        Utils.showToast(message, false);
      }
    } catch (e, stackTrace) {
      if (emit.isDone) return;

      emit(state.copyWith(isLoading: false));

      Utils.showToast(e.toString(), false);

      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  @override
  Future<void> close() async {
    final controller = state.searchController;
    await super.close();
    controller.dispose();
  }
}