import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:pabulum_teacher/model/submitted_homework_model.dart';
import 'package:pabulum_teacher/model/submittedwork_detail_model.dart';
import 'package:pabulum_teacher/network/api_service.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/utils.dart';

part 'submitted_work_event.dart';
part 'submitted_work_state.dart';
part 'submitted_work_bloc.freezed.dart';

class SubmittedHomeworkBloc
    extends Bloc<SubmittedHomeworkEvent, SubmittedHomeworkState> {
  final ApiService apiService = ApiService();

  SubmittedHomeworkBloc()
      : super(SubmittedHomeworkState.initial()) {
    on<OnLoadSubmittedHomework>(onLoadSubmittedHomework);
    on<OnLoadSubmittedHomeworkDetail>(onLoadSubmittedHomeworkDetail);
    on<OnSelectReviewStatus>(onSelectReviewStatus);
    on<OnSubmitReview>(onSubmitReview);
  }

  Future<void> onLoadSubmittedHomework(
      OnLoadSubmittedHomework event,
      Emitter<SubmittedHomeworkState> emit,
      ) async {
    if (event.page < 1) return;

    final query = event.query.trim();
    final isFirstPage = event.page == 1;

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
          errorMessage: null,
          arrSubmittedHomework:
          isFirstPage ? [] : state.arrSubmittedHomework,
          currentPage: isFirstPage ? 0 : state.currentPage,
          lastPage: isFirstPage ? 1 : state.lastPage,
          hasMore: isFirstPage ? true : state.hasMore,
        ),
      );

      final endpoint = Uri.parse(
        AppEndPoints.submittedHomeWork,
      );

      final url = endpoint.replace(
        queryParameters: {
          ...endpoint.queryParameters,
          'page': event.page.toString(),
          'q': query,
        },
      ).toString();

      final response = await apiService.getRequest(url);

      if (emit.isDone || query != state.query) return;

      if (response.statusCode == 200) {
        final result = SubmittedHomeworkModel.fromJson(
          Map<String, dynamic>.from(response.data as Map),
        );

        if (result.success == true) {
          final lastPage = result.lastPage ?? event.page;

          emit(
            state.copyWith(
              isLoading: false,
              isLoadingMore: false,
              currentPage: event.page,
              lastPage: lastPage.toInt(),
              hasMore: event.page < lastPage,
              arrSubmittedHomework: isFirstPage
                  ? (result.data ?? <SubmittedHomeworkData>[])
                  : [
                ...state.arrSubmittedHomework,
                ...(result.data ?? <SubmittedHomeworkData>[]),
              ],
              errorMessage: null,
            ),
          );
        } else {
          final message = result.message?.isEmpty == true
              ? 'Unable to load submitted homework.'
              : result.message;

          emit(
            state.copyWith(
              isLoading: false,
              isLoadingMore: false,
              errorMessage: message,
            ),
          );

          Utils.showToast(message, false);
        }
      } else {
        final body = response.data;

        final message = body is Map
            ? body['message']?.toString() ??
            response.statusMessage ??
            'Unable to load submitted homework.'
            : response.statusMessage ??
            'Unable to load submitted homework.';

        emit(
          state.copyWith(
            isLoading: false,
            isLoadingMore: false,
            errorMessage: message,
          ),
        );

        Utils.showToast(message, false);
      }
    } catch (e) {
      if (emit.isDone || query != state.query) return;

      final message = e.toString();

      emit(
        state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          errorMessage: message,
        ),
      );

      Utils.showToast(message, false);
      debugPrint(message);
    }
  }

  Future<void> onLoadSubmittedHomeworkDetail(
      OnLoadSubmittedHomeworkDetail event,
      Emitter<SubmittedHomeworkState> emit,
      ) async {
    if (state.isLoadingDetail || state.isSubmitting) return;

    state.commentController.clear();

    emit(
      state.copyWith(
        isLoadingDetail: true,
        isSubmitted: false,
        submittedHomeworkDetailData: null,
        selectedStatus: 'Submitted',
        detailErrorMessage: null,
        reviewErrorMessage: null,
        successMessage: null,
      ),
    );

    try {
      final response = await apiService.getRequest(
        '${AppEndPoints.submittedHomeWorkDetail}'
            '/${event.submittedHomeworkId}',
      );

      if (emit.isDone) return;

      if (response.statusCode == 200) {
        final result = SubmittedHomeworkDetailModel.fromJson(
          Map<String, dynamic>.from(response.data as Map),
        );

        if (result.success == true && result.data != null) {
          final detail = result.data!;

          state.commentController.text = detail.comment??'';

          emit(
            state.copyWith(
              isLoadingDetail: false,
              submittedHomeworkDetailData: result,
              selectedStatus: detail.status?.trim().toLowerCase() == 'checked'
                  ? 'Checked'
                  : 'Submitted',
              detailErrorMessage: null,
            ),
          );
        } else {
          final message = _message(
            result.message,
            'Unable to load submission details.',
          );

          emit(
            state.copyWith(
              isLoadingDetail: false,
              detailErrorMessage: message,
            ),
          );

          Utils.showToast(message, false);
        }
      } else {
        final message = _responseMessage(
          response.data,
          response.statusMessage ?? 'Unable to load submission details.',
        );

        emit(
          state.copyWith(
            isLoadingDetail: false,
            detailErrorMessage: message,
          ),
        );

        Utils.showToast(message, false);
      }
    } catch (e, stackTrace) {
      if (emit.isDone) return;

      final message = e.toString();

      emit(
        state.copyWith(
          isLoadingDetail: false,
          detailErrorMessage: message,
        ),
      );

      Utils.showToast(message, false);
      debugPrint(message);
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  void onSelectReviewStatus(
      OnSelectReviewStatus event,
      Emitter<SubmittedHomeworkState> emit,
      ) {
    if (state.isLoadingDetail ||
        state.isSubmitting ||
        state.isSubmitted) {
      return;
    }

    if (event.status != 'Submitted' && event.status != 'Checked') {
      return;
    }

    emit(
      state.copyWith(
        selectedStatus: event.status,
        reviewErrorMessage: null,
      ),
    );
  }

  Future<void> onSubmitReview(
      OnSubmitReview event,
      Emitter<SubmittedHomeworkState> emit,
      ) async {
    if (state.isLoadingDetail ||
        state.isSubmitting ||
        state.isSubmitted) {
      return;
    }

    final detail = state.submittedHomeworkDetailData;

    if (detail == null ) {
      Utils.showToast('Please load the submission first.', false);
      return;
    }

    // Read all values before awaiting the request.
    final data = {
      'submitted_homework_id': detail.data?.id,
      'comment': state.commentController.text.trim(),
      'status': state.selectedStatus,
    };

    emit(
      state.copyWith(
        isSubmitting: true,
        isSubmitted: false,
        reviewErrorMessage: null,
        successMessage: null,
      ),
    );

    try {
      final response = await apiService.postRequest(
        AppEndPoints.submittedHomeworkCheck,
        data,
      );

      if (emit.isDone) return;

      if (response.statusCode == 200) {
        final body = Map<String, dynamic>.from(response.data as Map);

        // Do not parse this response using the list/pagination model.
        if (body['success'] == true) {
          final message = _responseMessage(
            body,
            'Review saved successfully.',
          );

          emit(
            state.copyWith(
              isSubmitting: false,
              isSubmitted: true,
              successMessage: message,
              reviewErrorMessage: null,
            ),
          );

          Utils.showToast(message, true);
        } else {
          final message = _responseMessage(
            body,
            'Unable to save the review.',
          );

          emit(
            state.copyWith(
              isSubmitting: false,
              reviewErrorMessage: message,
            ),
          );

          Utils.showToast(message, false);
        }
      } else {
        final message = _responseMessage(
          response.data,
          response.statusMessage ?? 'Unable to save the review.',
        );

        emit(
          state.copyWith(
            isSubmitting: false,
            reviewErrorMessage: message,
          ),
        );

        Utils.showToast(message, false);
      }
    } catch (e, stackTrace) {
      if (emit.isDone) return;

      final message = e.toString();

      emit(
        state.copyWith(
          isSubmitting: false,
          reviewErrorMessage: message,
        ),
      );

      Utils.showToast(message, false);
      debugPrint(message);
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  String _message(dynamic value, String fallback) {
    final text = value?.toString().trim() ?? '';
    return text.isEmpty ? fallback : text;
  }

  String _responseMessage(dynamic body, String fallback) {
    return body is Map
        ? _message(body['message'], fallback)
        : fallback;
  }

  @override
  Future<void> close() async {
    final searchController = state.searchController;
    final commentController = state.commentController;

    await super.close();

    searchController.dispose();
    commentController.dispose();
  }
}