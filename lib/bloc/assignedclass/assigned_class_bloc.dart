import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pabulum_teacher/model/assigned_class_model.dart';

import 'package:pabulum_teacher/network/api_service.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/utils.dart';

part 'assigned_class_event.dart';
part 'assigned_class_state.dart';
part 'assigned_class_bloc.freezed.dart';

class AssignedClassesBloc
    extends Bloc<AssignedClassesEvent, AssignedClassesState> {
  final ApiService apiService = ApiService();

  AssignedClassesBloc() : super(AssignedClassesState.initial()) {
    on<OnLoadAssignedClasses>(onLoadAssignedClasses);
    on<OnSearchAssignedClasses>(onSearchAssignedClasses);
    on<OnClearAssignedClassesSearch>(onClearSearch);
  }

  Future<void> onLoadAssignedClasses(
      OnLoadAssignedClasses event,
      Emitter<AssignedClassesState> emit,
      ) async {
    if (state.isLoading) return;

    try {
      emit(
        state.copyWith(
          isLoading: true,
          errorMessage: null,
        ),
      );

      final response = await apiService.getRequest(
        AppEndPoints.myAssignedClass,
      );

      if (response.statusCode == 200) {
        final result = AssignedClassModel.fromJson(response.data);

        if (result.success == true) {
          emit(
            state.copyWith(
              isLoading: false,
              arrAssignedClasses: result.data ?? [],
              errorMessage: null,
            ),
          );
        } else {
          final message = _errorText(result.message);

          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: message,
            ),
          );

          Utils.showToast(message, false);
        }
      } else {
        final message = _errorText(response.statusMessage);

        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: message,
          ),
        );

        Utils.showToast(message, false);
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Unable to load assigned classes. Please try again.',
        ),
      );

      Utils.showToast(e, false);
      debugPrint(e.toString());
    }
  }

  // Local search only. No API request.
  void onSearchAssignedClasses(
      OnSearchAssignedClasses event,
      Emitter<AssignedClassesState> emit,
      ) {
    emit(state.copyWith(query: event.query));
  }

  // Restore the full list without another API request.
  void onClearSearch(
      OnClearAssignedClassesSearch event,
      Emitter<AssignedClassesState> emit,
      ) {
    state.searchController.clear();
    emit(state.copyWith(query: ''));
  }

  String _errorText(String? message) {
    final text = message?.trim() ?? '';

    return text.isEmpty
        ? 'Unable to load assigned classes. Please try again.'
        : text;
  }

  @override
  Future<void> close() async {
    state.searchController.dispose();
    await super.close();
  }
}