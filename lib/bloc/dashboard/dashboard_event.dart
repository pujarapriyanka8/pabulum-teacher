part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent.onLoadDashboardData() = OnLoadDashboardData;
  const factory DashboardEvent.onExpandClick() = OnExpandClick;
}
