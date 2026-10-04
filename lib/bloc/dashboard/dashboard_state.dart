part of 'dashboard_bloc.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({required bool isLoading,
  required DashboardData? dashboardData,
  required bool isExpanded}) = _DashboardState;

  factory DashboardState.initial() {
    return DashboardState(isLoading: false,dashboardData: DashboardData(),isExpanded: false);
  }
}
