import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pabulum_teacher/model/homework_detail_model.dart';
import 'package:pabulum_teacher/model/homework_model.dart';
import 'package:pabulum_teacher/network/api_service.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/utils.dart';

part 'homework_event.dart';
part 'homework_state.dart';
part 'homework_bloc.freezed.dart';

class HomeworkBloc extends Bloc<HomeworkEvent, HomeworkState> {
  final ApiService apiService = ApiService();

  HomeworkBloc() : super( HomeworkState.initial()) {
    on<OnLoadHomeworkData>(onLoadHomeworkData);
    on<OnLoadHomeworkDetail>(onLoadHomeworkDetail);
    on<OnDeleteHomework>(onDeleteHomework);


  }

  Future<void> onLoadHomeworkDetail(
      OnLoadHomeworkDetail event,
      Emitter<HomeworkState> emit,
      ) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,

        ),
      );

      final response = await apiService.getRequest(
        '${AppEndPoints.homeworkDetail}/${event.homeworkId}',
      );

      if (emit.isDone) return;

      if (response.statusCode == 200) {
        final result = HomeworkDetailModel.fromJson(response.data);

        if (result.success == true) {
          emit(
            state.copyWith(
              isLoading: false,
              homeworkDetailData: result.data,
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


  Future<void> onLoadHomeworkData(
      OnLoadHomeworkData event,
      Emitter<HomeworkState> emit,
      ) async {
    if (state.isLoading || state.isLoadingMore) return;

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
          search: event.search,
          arrHomeWork: isFirstPage ? [] : state.arrHomeWork,
          currentPage: isFirstPage ? 0 : state.currentPage,
          hasMore: isFirstPage ? true : state.hasMore,
        ),
      );

      final response = await apiService.getRequest(
        "${AppEndPoints.homeworks}?page=${event.page}&q=${event.search}",
      );

      if (response.statusCode == 200) {
        HomeworkModel homeworkModel =
        HomeworkModel.fromJson(response.data);

        if (homeworkModel.success == true) {
          emit(
            state.copyWith(
              isLoading: false,
              isLoadingMore: false,
              currentPage: event.page,
              lastPage: homeworkModel.lastPage?.toInt() ?? 1,
              hasMore:
              event.page < (homeworkModel.lastPage ?? 1),
              arrHomeWork: isFirstPage
                  ? (homeworkModel.data ?? [])
                  : [
                ...state.arrHomeWork,
                ...(homeworkModel.data ?? []),
              ],
            ),
          );
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              isLoadingMore: false,
            ),
          );

          Utils.showToast(homeworkModel.message, false);
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
      emit(
        state.copyWith(
          isLoading: false,
          isLoadingMore: false,
        ),
      );

      debugPrint(e.toString());
    }
  }

  Future<void> onDeleteHomework(
      OnDeleteHomework event,
      Emitter<HomeworkState> emit,
      ) async {
    if (state.isLoading || state.isLoadingMore) return;

    emit(state.copyWith(isLoading: true));

    try {
      final response = await apiService.postRequest(
        '${AppEndPoints.deleteHomeWork}/${event.homeworkId}',
        {},
      );

      if (emit.isDone) return;

      if (response.statusCode == 200) {
        // No pagination model is needed for the delete response.
        final body = Map<String, dynamic>.from(response.data as Map);

        if (body['success'] == true) {
          final message = body['message']?.toString() ??
              'Homework deleted successfully.';

          emit(
            state.copyWith(
              isLoading: false,
              arrHomeWork: state.arrHomeWork
                  .where((homework) => homework.id != event.homeworkId)
                  .toList(),
            ),
          );

          Utils.showToast(message, true);

          add(
            HomeworkEvent.onLoadHomeworkData(
              page: 1,
              search: state.search,
            ),
          );
        } else {
          emit(state.copyWith(isLoading: false));

          Utils.showToast(
            body['message']?.toString() ?? 'Unable to delete homework.',
            false,
          );
        }
      } else {
        emit(state.copyWith(isLoading: false));

        final body = response.data;

        final message = body is Map
            ? body['message']?.toString() ??
            response.statusMessage ??
            'Unable to delete homework.'
            : response.statusMessage ?? 'Unable to delete homework.';

        Utils.showToast(message, false);
      }
    } catch (e, stackTrace) {
      if (emit.isDone) return;

      emit(state.copyWith(isLoading: false));

      // Always pass a String to showToast.
      Utils.showToast(e.toString(), false);

      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}

