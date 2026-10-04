import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pabulum_teacher/main.dart';
import 'package:pabulum_teacher/model/login_response.dart';
import 'package:pabulum_teacher/model/profile_model.dart';
import 'package:pabulum_teacher/network/api_service.dart';
import 'package:pabulum_teacher/preferences/preferences.dart';
import 'package:pabulum_teacher/screen/main_navigation.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/constants.dart';
import 'package:pabulum_teacher/utils/utils.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService = ApiService();

  LoginBloc() : super(LoginState.initial()) {
    on<OnLoginClickEvent>(onLoginClickEvent);
    on<OnLoadProfileEvent>(onLoadProfileEvent);
  }

  Future<void> onLoginClickEvent(
    LoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      var data = {
        'username_or_email': state.userName.text,
        'password': state.password.text,
      };
      final response = await apiService.postRequest(AppEndPoints.login, data);
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        if (loginResponse.success == true) {
          Utils.showToast(loginResponse.message, true);
          Constants.shared.userLoginData = loginResponse.data;
          Preference.putString(
            Constants.loginUserData,
            jsonEncode(loginResponse.data),
          );
          Preference.putBoolean(Constants.isLogin, true);
          Navigator.pushAndRemoveUntil(
            navigatorKey.currentState!.context,
            MaterialPageRoute(builder: (context) => MainNavigation()),
            (Route<dynamic> route) => false,
          );
          emit(state.copyWith(isLoading: false, loginResponse: loginResponse));
        } else {
          print(loginResponse.message);
          emit(state.copyWith(isLoading: false));
          Utils.showToast(loginResponse.message, false);
        }
      } else {
        emit(state.copyWith(isLoading: false));
        Utils.showToast(response.statusMessage, false);
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Utils.showToast(e, false);
      debugPrint(e.toString());
    }
  }

  Future<void> onLoadProfileEvent(OnLoadProfileEvent event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final response = await apiService.getRequest(AppEndPoints.profile);
      if (response.statusCode == 200) {
        ProfileModel profileData = ProfileModel.fromJson(response.data);
        if (profileData.success == true) {
          emit(state.copyWith(isLoading: false, profileData: profileData.data));
        } else {
          print(profileData.message);
          emit(state.copyWith(isLoading: false));
          Utils.showToast(profileData.message, false);
        }
      } else {
        emit(state.copyWith(isLoading: false));
        Utils.showToast(response.statusMessage, false);
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Utils.showToast(e, false);
      debugPrint(e.toString());
    }
  }
}
