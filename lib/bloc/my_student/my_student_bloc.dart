import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pabulum_teacher/model/my_students.dart';
import 'package:pabulum_teacher/network/api_service.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/utils.dart';

part 'my_student_event.dart';

part 'my_student_state.dart';

part 'my_student_bloc.freezed.dart';

class MyStudentBloc extends Bloc<MyStudentEvent, MyStudentState> {
  final ApiService apiService = ApiService();

  MyStudentBloc() : super(MyStudentState.initial()) {
    on<OnLoadMyStudents>(onLoadMyStudent);
  }

  FutureOr<void> onLoadMyStudent(
    MyStudentEvent event,
    Emitter<MyStudentState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          query: event.query,
        ),
      );
      final endpoint = Uri.parse(AppEndPoints.myStudent);

      final url = endpoint.replace(
        queryParameters: {
          ...endpoint.queryParameters,
          'q': event.query.trim(),
        },
      ).toString();

      final response = await apiService.getRequest(url);
      if (response.statusCode == 200) {
        MyStudents myStudents = MyStudents.fromJson(response.data);
        if (myStudents.success == true) {

          emit(state.copyWith(isLoading: false, arrMyStudents: myStudents.data??[]));
        } else {
          Utils.showToast(myStudents.message, false);

          emit(state.copyWith(isLoading: false));
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
