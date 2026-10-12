
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/attendance/attendance_bloc.dart';
import 'package:pabulum_teacher/model/attendance_detail_model.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class AttendanceDetailsScreen extends StatelessWidget {
  const AttendanceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceID =
    ModalRoute.of(context)!.settings.arguments as num;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (context) => AttendanceBloc()
          ..add(
            AttendanceEvent.onLoadAttendanceDetails(
              attendanceId: attendanceID.toString(),
            ),
          ),
        child: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            final details = state.attendanceDetailData;
            final students =
                details?.attendanceStudents ?? <AttendanceStudents>[];

            return Stack(
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: CustomAppBar(
                              title: 'Attendance details',
                              subtitle:
                              'View detailed attendance\nfor a specific date',
                              image:
                              AppImages.icAttendanceStudent,
                            ),
                          ),
                          if (state.isLoading)
                            const Expanded(
                              child: SizedBox.shrink(),
                            )
                          else if (details == null)
                            const Expanded(
                              child: SizedBox.shrink(),
                            )
                          else
                            Expanded(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxHeight:
                                          constraints.maxHeight *
                                              0.60,
                                        ),
                                        child: SingleChildScrollView(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                            16,
                                            0,
                                            16,
                                            12,
                                          ),
                                          child:
                                          _buildSummary(details),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                          18,
                                          10,
                                          18,
                                          12,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Student attendance',
                                                style: TextStyle(
                                                  color: AppColors.ink,
                                                  fontSize: 20,
                                                  fontWeight:
                                                  FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${students.length} students',
                                              style: TextStyle(
                                                color: AppColors.muted,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: students.isEmpty
                                            ? Center(
                                          child: Text(
                                            'No student attendance available.',
                                            textAlign:
                                            TextAlign.center,
                                            style: TextStyle(
                                              color:
                                              AppColors.muted,
                                              fontSize: 13,
                                            ),
                                          ),
                                        )
                                            : ListView.builder(
                                          padding:
                                          const EdgeInsets.fromLTRB(
                                            16,
                                            0,
                                            16,
                                            16,
                                          ),
                                          itemCount:
                                          students.length,
                                          itemBuilder:
                                              (context, index) {
                                            final student =
                                            students[index];

                                            return Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                bottom: 9,
                                              ),
                                              child:
                                              studentAttendanceCard(
                                                student: student,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
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

  Widget _buildSummary(AttendanceDetailData details) {
    final present = details.present ?? 0;
    final absent = details.absent ?? 0;
    final total = present + absent;

    final progress = total > 0
        ? (present / total).clamp(0.0, 1.0).toDouble()
        : 0.0;

    final percentage =
    total > 0 ? '${(progress * 100).round()}%' : '—';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: AppColors.colorGrey1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.07),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.lavender,
                  borderRadius: BorderRadius.circular(16),
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
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDate(details.date ?? '—'),
                      style: TextStyle(
                        color: AppColors.ink,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getWeekday(details.date ?? ''),
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  Text(
                    percentage,
                    style: TextStyle(
                      color: AppColors.purple,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Attendance rate',
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Semantics(
            label: 'Attendance',
            value: total > 0
                ? '$present present, $absent absent'
                : 'No students',
            child: ExcludeSemantics(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 11,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final presentWidth =
                          constraints.maxWidth * progress;

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ColoredBox(
                            color: total > 0
                                ? AppColors.red
                                : AppColors.lavender,
                          ),
                          if (present > 0)
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              width: presentWidth,
                              child: ColoredBox(
                                color: AppColors.green,
                              ),
                            ),
                          if (present > 0 && absent > 0)
                            Positioned(
                              left: presentWidth - 1,
                              top: 0,
                              bottom: 0,
                              width: 2,
                              child: ColoredBox(
                                color: AppColors.white,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          LayoutBuilder(
            builder: (context, constraints) {
              final stackTiles =
                  constraints.maxWidth < 260 ||
                      MediaQuery.textScalerOf(context)
                          .scale(13) >
                          18;

              final tiles = [
                summaryCount(
                  label: 'Total',
                  value: total,
                  icon: Icons.groups_rounded,
                  color: AppColors.purple,
                  background: AppColors.lavender,
                ),
                summaryCount(
                  label: 'Present',
                  value: present,
                  icon: Icons.person_rounded,
                  color: AppColors.green,
                  background: AppColors.softBlue,
                ),
                summaryCount(
                  label: 'Absent',
                  value: absent,
                  icon: Icons.person_rounded,
                  color: AppColors.red,
                  background: AppColors.softPink,
                ),
              ];

              if (stackTiles) {
                return Column(
                  children: [
                    tiles[0],
                    const SizedBox(height: 8),
                    tiles[1],
                    const SizedBox(height: 8),
                    tiles[2],
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: tiles[0]),
                  const SizedBox(width: 8),
                  Expanded(child: tiles[1]),
                  const SizedBox(width: 8),
                  Expanded(child: tiles[2]),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(String value) {
    final date = _parseDate(value);
    if (date == null) return value;

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

  String _getWeekday(String value) {
    final date = _parseDate(value);
    if (date == null) return '';

    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return days[date.weekday - 1];
  }

  DateTime? _parseDate(String value) {
    final normalized = value.trim();
    final parsed = DateTime.tryParse(normalized);

    if (parsed != null) return parsed;

    final parts = normalized.split('-');
    if (parts.length != 3) return null;

    final first = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final last = int.tryParse(parts[2]);

    if (first == null ||
        month == null ||
        last == null) {
      return null;
    }

    final yearFirst = parts[0].length == 4;
    final year = yearFirst ? first : last;
    final day = yearFirst ? last : first;

    if (month < 1 ||
        month > 12 ||
        day < 1 ||
        day > 31) {
      return null;
    }

    final result = DateTime(year, month, day);

    if (result.year != year ||
        result.month != month ||
        result.day != day) {
      return null;
    }

    return result;
  }
}

Widget summaryCount({
  required String label,
  required num value,
  required Color color,
  required Color background,
  IconData? icon,
}) {
  return Container(
    height: 76,
    decoration: BoxDecoration(
      color: background.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: color,
            size: 22,
          ),
          const SizedBox(width: 5),
        ],
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value.toStringAsFixed(0),
              style: TextStyle(
                color: color,
                fontSize: 24,
                height: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget studentAttendanceCard({
  required AttendanceStudents student,
}) {
  final user = student.user;
  final isPresent = student.isPresent == 1;
  final isAbsent = student.isPresent == 0;

  final color = isPresent
      ? AppColors.green
      : isAbsent
      ? AppColors.red
      : AppColors.muted;

  final background = isPresent
      ? AppColors.softBlue
      : isAbsent
      ? AppColors.softPink
      : AppColors.lavender;

  final status = isPresent
      ? 'Present'
      : isAbsent
      ? 'Absent'
      : 'Unknown';

  final statusBadge = Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 9,
    ),
    decoration: BoxDecoration(
      color: background.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPresent
              ? Icons.check_circle_rounded
              : isAbsent
              ? Icons.cancel_rounded
              : Icons.help_outline_rounded,
          size: 18,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(
          status,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );

  return Container(
    height: 86,
    padding: const EdgeInsets.symmetric(
      horizontal: 12,
    ),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(19),
      border: Border.all(
        color: AppColors.colorGrey1,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.purple.withValues(alpha: 0.04),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final compact =
            constraints.maxWidth < 290 ||
                MediaQuery.textScalerOf(context).scale(14) > 18;

        return Row(
          children: [
            _StudentAvatar(
              imageUrl: user?.profileImage,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? 'Unknown student',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Roll number: ${user?.rollNumber ?? '—'}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                    ),
                  ),
                  if (compact) ...[
                    const SizedBox(height: 5),
                    statusBadge,
                  ],
                ],
              ),
            ),
            if (!compact) ...[
              const SizedBox(width: 8),
              statusBadge,
            ],
          ],
        );
      },
    ),
  );
}

class _StudentAvatar extends StatelessWidget {
  const _StudentAvatar({this.imageUrl});

  final String? imageUrl;

  Widget _fallback() {
    return Image.asset(
      AppImages.icProfile,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim();

    return ExcludeSemantics(
      child: ClipOval(
        child: SizedBox(
          width: 52,
          height: 52,
          child: url == null || url.isEmpty
              ? _fallback()
              : Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                _fallback(),
            loadingBuilder: (_, child, progress) {
              return progress == null
                  ? child
                  : _fallback();
            },
          ),
        ),
      ),
    );
  }
}
