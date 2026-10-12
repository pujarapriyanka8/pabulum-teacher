
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/attendance/attendance_bloc.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (context) => AttendanceBloc()
          ..add(
            const AttendanceEvent.onLoadAttendanceHistory(
              page: 1,
            ),
          ),
        child: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            final records = state.arrAttendanceHistory;
            final busy = state.isLoading || state.isLoadingMore;

            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    AppImages.icBackgroundAll,
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: CustomAppBar(
                          title: 'Attendance',
                          subtitle:
                          'View and manage\nattendance records',
                          image: AppImages.icAttendanceCalendar,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: _buildDateFilter(
                          context,
                          state,
                          busy,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Attendance history',
                                style: TextStyle(
                                  color: AppColors.ink,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            if (!state.isLoading &&
                                records.isNotEmpty)
                              Text(
                                '${records.length} records',
                                style: TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      Expanded(
                        child: records.isEmpty
                            ? state.isLoading
                            ? const SizedBox.shrink()
                            : _buildEmptyState(state)
                            : ListView.builder(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          itemCount: records.length + 1,
                          itemBuilder: (context, index) {
                            if (index == records.length) {
                              return _buildPagination(
                                context,
                                state,
                              );
                            }

                            final record = records[index];

                            return Padding(
                              padding:
                              const EdgeInsets.only(
                                bottom: 8,
                              ),
                              child: _buildHistoryCard(
                                date: record.date ?? '—',
                                present:
                                record.presentCount ?? 0,
                                absent:
                                record.absentCount ?? 0,
                                index: index,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteName
                                        .attendanceDetailScreen,
                                    arguments: record.id,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          16,
                          6,
                          16,
                          10,
                        ),
                        child: _buildTakeAttendanceButton(
                          context,
                          busy,
                        ),
                      ),
                    ],
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

  Widget _buildDateFilter(
      BuildContext context,
      AttendanceState state,
      bool busy,
      ) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: busy
            ? null
            : () => _selectDate(
          context,
          state.filterDate,
        ),
        child: Container(
          height: 82,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.colorGrey1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.purple.withValues(
                  alpha: 0.07,
                ),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 53,
                height: 53,
                decoration: BoxDecoration(
                  color: AppColors.lavender,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.calendar_month_rounded,
                  color: AppColors.purple,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter by date',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      state.filterDate == null
                          ? 'Select date'
                          : _formatDate(state.filterDate!),
                      style: TextStyle(
                        color: AppColors.ink,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              if (state.filterDate != null)
                IconButton(
                  onPressed: busy
                      ? null
                      : () {
                    context.read<AttendanceBloc>().add(
                      const AttendanceEvent
                          .onLoadAttendanceHistory(
                        page: 1,
                        date: null,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    color: AppColors.muted,
                  ),
                )
              else
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.purple,
                  size: 28,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard({
    required String date,
    required num present,
    required num absent,
    required int index,
    VoidCallback? onTap,
  }) {
    final total = present + absent;

    final progress = total > 0
        ? (present / total).clamp(0.0, 1.0).toDouble()
        : 0.0;

    final percentage = total > 0
        ? '${(progress * 100).round()}%'
        : '—';

    final dateInfo = _getDateInfo(date);

    final accentColors = [
      AppColors.softBlue,
      AppColors.peach,
      AppColors.softPink,
      AppColors.lavender,
    ];

    final accent = accentColors[index % accentColors.length];

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 88,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.colorGrey1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.purple.withValues(
                  alpha: 0.04,
                ),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 7,
                height: 65,
                margin: const EdgeInsets.only(left: 7),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 7),

              Container(
                width: 110,
                height: 67,
                decoration: BoxDecoration(
                  color: AppColors.lavender.withValues(
                    alpha: 0.65,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: AppColors.purple,
                      size: 22,
                    ),
                    const SizedBox(width: 7),
                    Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          dateInfo.day,
                          style: TextStyle(
                            color: AppColors.ink,
                            fontSize: 19,
                            height: 1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dateInfo.month,
                          style: TextStyle(
                            color: AppColors.ink,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          dateInfo.year,
                          style: TextStyle(
                            color: AppColors.ink,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${present.toStringAsFixed(0)} present',
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${absent.toStringAsFixed(0)} absent',
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 56,
                width: 56,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 5,
                        strokeCap: StrokeCap.round,
                        backgroundColor:
                        AppColors.lavender,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(
                          AppColors.purple,
                        ),
                      ),
                    ),
                    Text(
                      percentage,
                      style: TextStyle(
                        color: AppColors.purple,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.muted,
                size: 24,
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTakeAttendanceButton(
      BuildContext context,
      bool busy,
      ) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.purple,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(
              alpha: 0.22,
            ),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: busy
              ? null
              : () {
            Navigator.pushNamed(
              context,
              RouteName.takeAttendanceScreen,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_available_outlined,
                color: AppColors.white,
                size: 23,
              ),
              const SizedBox(width: 10),
              Text(
                'Take attendance',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 18),
              Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.white,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(AttendanceState state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: AppColors.lavender,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.event_busy_rounded,
              color: AppColors.purple,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'No attendance records',
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (state.filterDate != null) ...[
            const SizedBox(height: 5),
            Text(
              'No attendance found for this date.',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPagination(
      BuildContext context,
      AttendanceState state,
      ) {
    if (state.isLoadingMore) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.purple,
          ),
        ),
      );
    }

    if (!state.hasMore) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'All records loaded',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.muted,
            fontSize: 12,
          ),
        ),
      );
    }

    return Center(
      child: OutlinedButton(
        onPressed: () {
          _loadMore(context, state);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.purple,
          side: BorderSide(
            color: AppColors.purple,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: const Text('Load more'),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context,
      DateTime? selectedDate,
      ) async {
    final today = DateUtils.dateOnly(DateTime.now());

    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? today,
      firstDate: DateTime(2000),
      lastDate: today,
    );

    if (date != null && context.mounted) {
      context.read<AttendanceBloc>().add(
        AttendanceEvent.onLoadAttendanceHistory(
          page: 1,
          date: date,
        ),
      );
    }
  }

  void _loadMore(
      BuildContext context,
      AttendanceState state,
      ) {
    if (state.isLoading ||
        state.isLoadingMore ||
        !state.hasMore) {
      return;
    }

    context.read<AttendanceBloc>().add(
      AttendanceEvent.onLoadAttendanceHistory(
        page: state.currentPage + 1,
        date: state.filterDate,
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${date.day.toString().padLeft(2, '0')} '
        '${months[date.month - 1]} ${date.year}';
  }

  _AttendanceDateInfo _getDateInfo(String value) {
    final parts = value.trim().split('-');

    if (parts.length != 3) {
      return _AttendanceDateInfo(
        day: value,
        month: '',
        year: '',
      );
    }

    final yearFirst = parts.first.length == 4;

    final day = int.tryParse(
      yearFirst ? parts[2] : parts[0],
    );

    final month = int.tryParse(parts[1]);

    final year = int.tryParse(
      yearFirst ? parts[0] : parts[2],
    );

    if (day == null ||
        month == null ||
        year == null ||
        month < 1 ||
        month > 12) {
      return _AttendanceDateInfo(
        day: value,
        month: '',
        year: '',
      );
    }

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return _AttendanceDateInfo(
      day: day.toString().padLeft(2, '0'),
      month: months[month - 1],
      year: year.toString(),
    );
  }
}

class _AttendanceDateInfo {
  const _AttendanceDateInfo({
    required this.day,
    required this.month,
    required this.year,
  });

  final String day;
  final String month;
  final String year;
}
