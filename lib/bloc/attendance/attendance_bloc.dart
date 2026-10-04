import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pabulum_teacher/model/attendance_detail_model.dart';
import 'package:pabulum_teacher/model/attendance_history_model.dart';
import 'package:pabulum_teacher/model/my_students.dart';
import 'package:pabulum_teacher/network/api_service.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/utils.dart';

part 'attendance_event.dart';

part 'attendance_state.dart';

part 'attendance_bloc.freezed.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final ApiService apiService = ApiService();

  AttendanceBloc() : super(AttendanceState.initial()) {
    on<OnLoadAttendanceHistory>(onLoadAttendanceHistory);
    on<OnLoadAttendanceDetails>(onLoadAttendanceDetails);
    on<OnChangeAttendanceDate>(onChangeAttendanceDate);
    on<OnChangeStudentAttendance>(onChangeStudentAttendance);
    on<OnMarkAllAttendance>(onMarkAllAttendance);
    on<OnSubmitAttendance>(onSubmitAttendance);
  }


  void onChangeAttendanceDate(
      OnChangeAttendanceDate event,
      Emitter<AttendanceState> emit,
      ) {
    if (state.isSubmitting) return;

    emit(
      state.copyWith(
        attendanceDate: DateUtils.dateOnly(event.date),
        isSubmitted: false,
      ),
    );
  }

  void onChangeStudentAttendance(
      OnChangeStudentAttendance event,
      Emitter<AttendanceState> emit,
      ) {
    if (state.isLoading || state.isSubmitting) return;

    if (!state.attendanceStatus.containsKey(event.studentId)) return;

    emit(
      state.copyWith(
        attendanceStatus: {
          ...state.attendanceStatus,
          event.studentId: event.isPresent,
        },
        isSubmitted: false,
      ),
    );
  }

  void onMarkAllAttendance(
      OnMarkAllAttendance event,
      Emitter<AttendanceState> emit,
      ) {
    if (state.isLoading || state.isSubmitting) return;

    emit(
      state.copyWith(
        attendanceStatus: {
          for (final student in event.students)
            if (student.id != null)
              student.id.toString(): event.isPresent,
        },
        isSubmitted: false,
      ),
    );
  }

  Future<void> onSubmitAttendance(
      OnSubmitAttendance event,
      Emitter<AttendanceState> emit,
      ) async {
    if (state.isLoading || state.isSubmitting) return;

    final students = event.students;

    if (students.isEmpty) {
      Utils.showToast('No students available.', false);
      return;
    }

    final hasMissingStatus = students.any(
          (student) =>
      student.id == null ||
          !state.attendanceStatus.containsKey(student.id.toString()),
    );

    if (hasMissingStatus) {
      Utils.showToast('Please mark attendance for all students.', false);
      return;
    }

    try {
      emit(
        state.copyWith(
          isSubmitting: true,
          isSubmitted: false,
        ),
      );

      final body = {
        'date': Utils.formatAttendanceDate(state.attendanceDate),

        'attendance': students.map((student) {
          return {
            'student_id': student.id,
            'is_present':
            state.attendanceStatus[student.id.toString()] == true
                ? 1
                : 0,
          };
        }).toList(),
      };

      final response = await apiService.postRequest(
        AppEndPoints.attendanceSave,
        body,
      );

      if (response.statusCode == 200) {
        final result = Map<String, dynamic>.from(
          response.data as Map,
        );

        if (result['success'] == true) {
          emit(
            state.copyWith(
              isSubmitting: false,
              isSubmitted: true,
            ),
          );

          Utils.showToast(
            result['message']?.toString() ??
                'Attendance saved successfully.',
            true,
          );
        } else {
          emit(state.copyWith(isSubmitting: false));

          Utils.showToast(
            result['message']?.toString() ??
                'Unable to save attendance.',
            false,
          );
        }
      } else {
        emit(state.copyWith(isSubmitting: false));

        Utils.showToast(
          response.statusMessage ?? 'Unable to save attendance.',
          false,
        );
      }
    } catch (e) {
      debugPrint(e.toString());

      if (emit.isDone) return;

      emit(state.copyWith(isSubmitting: false));

      Utils.showToast(
        'Unable to save attendance. Please retry.',
        false,
      );
    }
  }

  Future<void> onLoadAttendanceHistory(
      OnLoadAttendanceHistory event,
    Emitter<AttendanceState> emit,
  ) async {
    if (state.isLoading || state.isLoadingMore) return;
    if (event.page < 1) return;
    final isFirstPage = event.page == 1;
    final selectedDate = event.date == null
        ? null
        : DateUtils.dateOnly(event.date!);

    if (!isFirstPage) {
      final sameFilter =
          selectedDate == null && state.filterDate == null ||
          selectedDate != null &&
              state.filterDate != null &&
              DateUtils.isSameDay(selectedDate, state.filterDate);

      // Load pages in order and keep the same filter.
      if (!state.hasMore ||
          state.currentPage == 0 ||
          event.page != state.currentPage + 1 ||
          !sameFilter) {
        return;
      }
    }

    try {
      emit(
        state.copyWith(
          isLoading: isFirstPage,
          isLoadingMore: !isFirstPage,
          filterDate: event.date,
          arrAttendanceHistory: isFirstPage ? [] : state.arrAttendanceHistory,
          currentPage: isFirstPage ? 0 : state.currentPage,
          hasMore: isFirstPage ? true : state.hasMore,
        ),
      );

      final queryParameters = <String, String>{'page': event.page.toString()};

      if (selectedDate != null) {
        queryParameters['date'] = Utils.formatAttendanceDate(selectedDate);
      }
      final endpoint = Uri.parse(AppEndPoints.attendanceHistory);

      final url = endpoint
          .replace(
            queryParameters: {...endpoint.queryParameters, ...queryParameters},
          )
          .toString();

      final response = await apiService.getRequest(url);

      if (response.statusCode == 200) {
        AttendanceHistoryModel arrAttendanceHistory =
            AttendanceHistoryModel.fromJson(response.data);
        if (arrAttendanceHistory.success == true) {
          emit(
            state.copyWith(
              isLoading: false,
              isLoadingMore: false,
              filterDate: selectedDate,
              currentPage: event.page,
              arrAttendanceHistory: isFirstPage
                  ? (arrAttendanceHistory.data ?? [])
                  : [
                      ...state.arrAttendanceHistory,
                      ...(arrAttendanceHistory.data ?? []),
                    ],
              hasMore: arrAttendanceHistory.data?.isNotEmpty ?? false,
            ),
          );
        } else {
          Utils.showToast(arrAttendanceHistory.message, false);

          emit(state.copyWith(isLoading: false, isLoadingMore: false));
        }
      } else {
        emit(state.copyWith(isLoading: false, isLoadingMore: false));
        Utils.showToast(response.statusMessage, false);
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, isLoadingMore: false));
      Utils.showToast(e, false);
      debugPrint(e.toString());
    }
  }

  Future<void> onLoadAttendanceDetails(
    OnLoadAttendanceDetails event,
    Emitter<AttendanceState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final response = await apiService.getRequest(
        '${AppEndPoints.attendanceDetail}/${event.attendanceId}',
      );
      if (response.statusCode == 200) {
        AttendanceDetailModel attendanceDetailModel =
            AttendanceDetailModel.fromJson(response.data);
        if (attendanceDetailModel.success == true) {
          emit(
            state.copyWith(
              isLoading: false,
              attendanceDetailData: attendanceDetailModel.data,
            ),
          );
        } else {
          emit(state.copyWith(isLoading: false));
          Utils.showToast(attendanceDetailModel.message, false);
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
}
