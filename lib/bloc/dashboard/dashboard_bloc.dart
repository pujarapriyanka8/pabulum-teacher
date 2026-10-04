import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pabulum_teacher/model/dashboard_model.dart';
import 'package:pabulum_teacher/network/api_service.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/utils.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

part 'dashboard_bloc.freezed.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  ApiService apiService = ApiService();

  DashboardBloc() : super(DashboardState.initial()) {
    on<OnLoadDashboardData>(onLoadDashboardData);
    on<OnExpandClick>(onExpandClick);
  }

  Future<void> onLoadDashboardData(
    DashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final response = await apiService.getRequest(AppEndPoints.dashboard);
      if (response.statusCode == 200) {
        DashboardModel dashboardData = DashboardModel.fromJson(response.data);
        if (dashboardData.success == true) {

          emit(
            state.copyWith(isLoading: false, dashboardData: dashboardData.data),
          );
        } else {
          emit(state.copyWith(isLoading: false));
          Utils.showToast(dashboardData.message, false);
        }
      } else {
        emit(state.copyWith(isLoading: false));
        Utils.showToast(response.statusMessage, false);
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      debugPrint(e.toString());
    }
  }

  FutureOr<void> onExpandClick(OnExpandClick event, Emitter<DashboardState> emit) {
  emit(state.copyWith(isExpanded: !state.isExpanded));
  }
}
