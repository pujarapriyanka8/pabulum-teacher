
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pabulum_teacher/bloc/timetable/timetable_bloc.dart';
import 'package:pabulum_teacher/model/timetable_model.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (_) => TimetableBloc()
          ..add(const TimetableEvent.onLoadTimetable()),
        child: BlocBuilder<TimetableBloc, TimetableState>(
          builder: (context, state) {
            final totalLectures = state.arrTimetable.fold<int>(
              0,
                  (total, day) =>
              total + (day.periods?.length ?? 0),
            );

            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    AppImages.icBackgroundAll,
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints:
                      const BoxConstraints(maxWidth: 700),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: CustomAppBar(
                              title: 'Timetable',
                              subtitle:
                              'Your weekly class schedule\nat a glance.',
                              image: AppImages.icTimetable,
                            ),
                          ),
                          _buildHeader(
                            totalLectures: totalLectures,
                            hasTimetable:
                            state.arrTimetable.isNotEmpty,
                          ),
                          Expanded(
                            child: state.arrTimetable.isEmpty
                                ? state.isLoading
                                ? const SizedBox.shrink()
                                : _buildEmptyMessage(
                              state.errorMessage,
                            )
                                : ListView.builder(
                              keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior
                                  .onDrag,
                              padding:
                              const EdgeInsets.fromLTRB(
                                16,
                                0,
                                16,
                                16,
                              ),
                              itemCount:
                              state.arrTimetable.length,
                              itemBuilder: (context, index) {
                                final day =
                                state.arrTimetable[index];

                                final dayName = day.day ?? '';

                                final dayKey = dayName
                                    .trim()
                                    .toLowerCase();

                                final today =
                                TimetableBloc.weekDays[
                                DateTime.now()
                                    .weekday -
                                    1];

                                return Padding(
                                  key: ValueKey(dayKey),
                                  padding:
                                  const EdgeInsets.only(
                                    bottom: 12,
                                  ),
                                  child: _buildTimetableDayCard(
                                    day: day,
                                    index: index,
                                    isToday: dayKey ==
                                        today.toLowerCase(),
                                    isExpanded: state.expandedDays
                                        .contains(dayKey),
                                    onTap: () {
                                      context
                                          .read<TimetableBloc>()
                                          .add(
                                        TimetableEvent
                                            .onToggleDay(
                                          day: dayName,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.isLoading) Utils.loaderBrier(),
                if (state.isLoading) Utils.loaderWid(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader({
    required int totalLectures,
    required bool hasTimetable,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        16,
        0,
        16,
        14,
      ),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF3E9FF),
            Color(0xFFF2F0FF),
            Color(0xFFEAF3FF),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFDED3F8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFFE6DDFC),
              ),
            ),
            child: Icon(
              Icons.calendar_month_rounded,
              color: AppColors.purple,
              size: 29,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weekly schedule',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your classes, day by day',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                  ),
                ),
                if (hasTimetable) ...[
                  const SizedBox(height: 9),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFDDD2FC),
                      ),
                    ),
                    child: Text(
                      '$totalLectures '
                          '${totalLectures == 1 ? 'lecture' : 'lectures'} '
                          'this week',
                      style: TextStyle(
                        color: AppColors.purple,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyMessage(String? errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Text(
          errorMessage ?? 'No timetable available.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 15,
            height: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTimetableDayCard({
    required TimeTableData day,
    required int index,
    required bool isToday,
    required bool isExpanded,
    required VoidCallback onTap,
  }) {
    final periods = day.periods ?? <Periods>[];

    final accentColor =
    Utils.getCardBorderColor(index);

    return Container(
      width: double.infinity,
      decoration: Utils.cardDecoration(
        index: index,
        radius: 18,
        topWidth: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            button: true,
            label:
            '${_displayText(day.day)}, '
                '${periods.length} lectures, '
                '${isExpanded ? 'expanded' : 'collapsed'}',
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(18),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 39,
                        height: 39,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: accentColor.withValues(
                            alpha: 0.13,
                          ),
                          borderRadius:
                          BorderRadius.circular(11),
                        ),
                        child: Icon(
                          Icons.calendar_month_outlined,
                          size: 22,
                          color: accentColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Wrap(
                          spacing: 7,
                          runSpacing: 5,
                          crossAxisAlignment:
                          WrapCrossAlignment.center,
                          children: [
                            Text(
                              _displayText(day.day),
                              style: TextStyle(
                                color: AppColors.ink,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            if (isToday)
                              Container(
                                padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.purple,
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child: Text(
                                  'Today',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${periods.length} '
                            '${periods.length == 1 ? 'lecture' : 'lectures'}',
                        style: TextStyle(
                          color: AppColors.muted,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: accentColor,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration:
            const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: isExpanded
                ? Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                0,
                12,
                12,
              ),
              child: periods.isEmpty
                  ? Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'No lectures scheduled.',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 13,
                  ),
                ),
              )
                  : Column(
                children: [
                  for (int i = 0;
                  i < periods.length;
                  i++)
                    _buildLectureTimelineRow(
                      period: periods[i],
                      isFirst: i == 0,
                      isLast:
                      i == periods.length - 1,
                    ),
                ],
              ),
            )
                : const SizedBox(
              width: double.infinity,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLectureTimelineRow({
    required Periods period,
    required bool isFirst,
    required bool isLast,
  }) {
    final palette =
    _paletteFor(period.subjectName);

    return Stack(
      children: [
        Positioned(
          left: 5,
          top: isFirst ? 21 : 0,
          bottom: isLast ? null : 0,
          height: isLast
              ? (isFirst ? 0 : 21)
              : null,
          child: Container(
            width: 2,
            color: const Color(0xFFE0E3EF),
          ),
        ),
        Positioned(
          left: 0,
          top: 16,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: palette.accent,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.white,
                width: 2,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 22,
            bottom: isLast ? 0 : 10,
          ),
          child: _buildLectureCard(
            period: period,
            backgroundColor: palette.background,
            accentColor: palette.accent,
          ),
        ),
      ],
    );
  }

  Widget _buildLectureCard({
    required Periods period,
    required Color backgroundColor,
    required Color accentColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: accentColor.withValues(
            alpha: 0.22,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_formatTime(period.startTime)}'
                ' – ${_formatTime(period.endTime)}',
            style: TextStyle(
              color: accentColor,
              fontSize: 13,
              height: 1.3,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 9),
          LayoutBuilder(
            builder: (context, constraints) {
              final subject = _buildSubject(
                period: period,
                accentColor: accentColor,
              );

              final classChip = _buildClassChip(
                period: period,
                accentColor: accentColor,
              );

              final useTwoRows =
                  constraints.maxWidth < 230 ||
                      MediaQuery.textScalerOf(context)
                          .scale(13) >
                          18;

              if (useTwoRows) {
                return Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    subject,
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: classChip,
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: subject),
                  const SizedBox(width: 8),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                      constraints.maxWidth * 0.45,
                    ),
                    child: classChip,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubject({
    required Periods period,
    required Color accentColor,
  }) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.menu_book_rounded,
          size: 22,
          color: accentColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            _displayText(period.subjectName),
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassChip({
    required Periods period,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: accentColor.withValues(
          alpha: 0.10,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        '${_displayText(period.standardName)}'
            ' • ${_displayText(period.divisionName)}',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: accentColor,
          fontSize: 11,
          height: 1.3,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  static const _lecturePalettes =
  <({Color background, Color accent})>[
    (
    background: Color(0xFFF2ECFF),
    accent: Color(0xFF7850D5),
    ),
    (
    background: Color(0xFFEAF9F1),
    accent: Color(0xFF169867),
    ),
    (
    background: Color(0xFFEBF3FF),
    accent: Color(0xFF367CDD),
    ),
    (
    background: Color(0xFFFFF2E7),
    accent: Color(0xFFB66B25),
    ),
  ];

  ({Color background, Color accent}) _paletteFor(
      String? subject,
      ) {
    final value = (subject ?? '').codeUnits.fold<int>(
      0,
          (sum, character) => sum + character,
    );

    return _lecturePalettes[
    value % _lecturePalettes.length];
  }

  String _displayText(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? '—' : text;
  }

  String _formatTime(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) return '—';

    final parts = text.split(':');

    if (parts.length < 2) return text;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null ||
        minute == null ||
        hour < 0 ||
        hour > 23 ||
        minute < 0 ||
        minute > 59) {
      return text;
    }

    final hour12 =
    hour % 12 == 0 ? 12 : hour % 12;

    final minuteText =
    minute.toString().padLeft(2, '0');

    final suffix =
    hour >= 12 ? 'PM' : 'AM';

    return '$hour12:$minuteText $suffix';
  }
}
