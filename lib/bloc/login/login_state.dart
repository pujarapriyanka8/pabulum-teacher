part of 'login_bloc.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    required bool isLoading,
    required TextEditingController userName,
    required TextEditingController password,
    required LoginResponse? loginResponse,
    required ProfileData? profileData
  }) = _LoginState;

  factory LoginState.initial() {
    return  LoginState(isLoading: false,
        userName: TextEditingController(),
        password: TextEditingController(),
        loginResponse: null,
    profileData: null);
  }
}