part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.onLoginClickEvent() = OnLoginClickEvent;
  const factory LoginEvent.onLoadProfileEvent() = OnLoadProfileEvent;
}
