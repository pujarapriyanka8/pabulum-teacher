import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:pabulum_teacher/model/timetable_model.dart';
import 'package:pabulum_teacher/network/api_service.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/utils.dart';

part 'timetable_event.dart';
part 'timetable_state.dart';
part 'timetable_bloc.freezed.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  final ApiService apiService = ApiService();

  TimetableBloc() : super(TimetableState.initial()) {
    on<OnLoadTimetable>(onLoadTimetable);
    on<OnToggleDay>(onToggleDay);
  }

  static const weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  Future<void> onLoadTimetable(
      OnLoadTimetable event,
      Emitter<TimetableState> emit,
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
        AppEndPoints.timeTable,
      );

      if (response.statusCode == 200) {
        // Show the API error before attempting to parse the model.
        if (response.data['success'] != true) {
          final message = _errorText(response.data['message']);

          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: message,
            ),
          );

          Utils.showToast(message, false);
          return;
        }

        final timetableModel = TimetableModel.fromJson(response.data);
        final timetable = <TimeTableData>[];

        for (final item in timetableModel.data ?? <TimeTableData>[]) {
          final periods = List<Periods>.from(
            item.periods ?? <Periods>[],
          );

          periods.sort(
                (a, b) => _timeValue(a.startTime).compareTo(
              _timeValue(b.startTime),
            ),
          );

          timetable.add(
            TimeTableData(
              day: item.day,
              periods: periods,
            ),
          );
        }

        timetable.sort(
              (a, b) => _dayOrder(a.day).compareTo(_dayOrder(b.day)),
        );

        final today = weekDays[DateTime.now().weekday - 1];

        final availableDays = timetable
            .map((item) => (item.day ?? '').trim().toLowerCase())
            .toSet();

        final Set<String> expandedDays;

        if (state.arrTimetable.isEmpty) {
          final todayKey = today.toLowerCase();

          expandedDays = availableDays.contains(todayKey)
              ? {todayKey}
              : <String>{};
        } else {
          // Preserve open days when reloading.
          expandedDays = state.expandedDays
              .where(availableDays.contains)
              .toSet();
        }

        emit(
          state.copyWith(
            isLoading: false,
            arrTimetable: timetable,
            expandedDays: expandedDays,
            errorMessage: null,
          ),
        );
      } else {
        final responseData = response.data;

        final message = _errorText(
          responseData is Map
              ? responseData['message'] ?? response.statusMessage
              : response.statusMessage,
        );

        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: message,
          ),
        );

        Utils.showToast(message, false);
      }
    } catch (e) {
      const message = 'Unable to load timetable. Please try again.';

      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: message,
        ),
      );

      Utils.showToast(message, false);
      debugPrint(e.toString());
    }
  }

  void onToggleDay(
      OnToggleDay event,
      Emitter<TimetableState> emit,
      ) {
    final day = event.day.trim().toLowerCase();
    final expandedDays = Set<String>.from(state.expandedDays);

    if (expandedDays.contains(day)) {
      expandedDays.remove(day);
    } else {
      expandedDays.add(day);
    }

    emit(state.copyWith(expandedDays: expandedDays));
  }

  int _dayOrder(String? day) {
    final index = weekDays.indexWhere(
          (value) => value.toLowerCase() == day?.trim().toLowerCase(),
    );

    return index == -1 ? 7 : index;
  }

  int _timeValue(String? time) {
    final parts = time?.split(':') ?? [];

    if (parts.length < 2) return 24 * 60;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null || minute == null) return 24 * 60;

    return hour * 60 + minute;
  }

  String _errorText(String? message) {
    final text = message?.trim() ?? '';

    return text.isEmpty
        ? 'Unable to load timetable. Please try again.'
        : text;
  }
}