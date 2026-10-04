import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/attendance/attendance_bloc.dart';
import 'package:pabulum_teacher/model/attendance_detail_model.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class AttendanceDetailsScreen extends StatelessWidget {
  const AttendanceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceID =
    ModalRoute.of(context)!.settings.arguments as num;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: Utils.customAppBar(
        'Attendance details',
        context,
        isBack: true,
        onBackPress: () {
          Navigator.of(context).pop();
        },
      ),
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
                SafeArea(
                  top: false,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: state.isLoading
                          ? const SizedBox.expand()
                          : details == null
                          ? const SizedBox.shrink()
                          : LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              // Summary is separate from the list.
                              // Limit its height on smaller screens.
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight:
                                  constraints.maxHeight * 0.60,
                                ),
                                child: SingleChildScrollView(
                                  padding:
                                  const EdgeInsets.fromLTRB(
                                    20,
                                    20,
                                    20,
                                    16,
                                  ),
                                  child: _buildSummary(details),
                                ),
                              ),

                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(
                                  20,
                                  4,
                                  20,
                                  14,
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Student attendance',
                                        style: TextStyle(
                                          color: Color(0xFF202329),
                                          fontSize: 19,
                                          fontWeight:
                                          FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      '${students.length} students',
                                      style: const TextStyle(
                                        color: Color(0xFF737B90),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Only student records belong here.
                              Expanded(
                                child: students.isEmpty
                                    ? const Center(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.all(20),
                                    child: Text(
                                      'No student attendance available.',
                                      textAlign:
                                      TextAlign.center,
                                      style: TextStyle(
                                        color:
                                        Color(0xFF737B90),
                                      ),
                                    ),
                                  ),
                                )
                                    : ListView.builder(
                                  padding:
                                  const EdgeInsets
                                      .fromLTRB(
                                    20,
                                    0,
                                    20,
                                    24,
                                  ),
                                  itemCount: students.length,
                                  itemBuilder:
                                      (context, index) {
                                    final student =
                                    students[index];

                                    return Padding(
                                      padding:
                                      const EdgeInsets
                                          .only(
                                        bottom: 12,
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

    const green = Color(0xFF159654);
    const red = Color(0xFFEF5369);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE9E5F5),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08704CFF),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date and percentage in the same row.
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EBFF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: Color(0xFF704CFF),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  details.date ?? '—',
                  style: const TextStyle(
                    color: Color(0xFF202329),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                percentage,
                style: const TextStyle(
                  color: Color(0xFF704CFF),
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Semantics(
            label: 'Attendance',
            value: total > 0
                ? '$present present, $absent absent'
                : 'No students',
            child: ExcludeSemantics(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 12,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final presentWidth =
                          constraints.maxWidth * progress;

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          ColoredBox(
                            color: total > 0
                                ? red
                                : const Color(0xFFECEEF3),
                          ),
                          if (present > 0)
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              width: presentWidth,
                              child: const ColoredBox(color: green),
                            ),

                          // Thin divider only when both groups exist.
                          if (present > 0 && absent > 0)
                            Positioned(
                              left: presentWidth - 1,
                              top: 0,
                              bottom: 0,
                              width: 2,
                              child: const ColoredBox(
                                color: Colors.white,
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
          const SizedBox(height: 14),

          // Existing summary tiles.
          LayoutBuilder(
            builder: (context, constraints) {
              final stackTiles = constraints.maxWidth < 260 ||
                  MediaQuery.textScalerOf(context).scale(13) > 18;

              final tiles = [
                summaryCount(
                  label: 'Total',
                  value: total,
                  icon: Icons.people_outline_rounded,
                  color: const Color(0xFF6340ED),
                  background: const Color(0xFFF0EBFF),
                ),
                summaryCount(
                  label: 'Present',
                  value: present,
                  icon: Icons.check_circle_outline_rounded,
                  color: green,
                  background: const Color(0xFFE8F7EF),
                ),
                summaryCount(
                  label: 'Absent',
                  value: absent,
                  icon: Icons.cancel_outlined,
                  color: red,
                  background: const Color(0xFFFFEDF1),
                ),
              ];

              if (stackTiles) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    tiles[0],
                    const SizedBox(height: 10),
                    tiles[1],
                    const SizedBox(height: 10),
                    tiles[2],
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: tiles[0]),
                  const SizedBox(width: 10),
                  Expanded(child: tiles[1]),
                  const SizedBox(width: 10),
                  Expanded(child: tiles[2]),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget summaryCount({
  required String label,
  required num value,
  required Color color,
  required Color background,
  IconData? icon, // Keeps existing calls compatible; not displayed.
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          value.toStringAsFixed(0),
          style: TextStyle(
            color: color,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
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
      ? const Color(0xFF159654)
      : isAbsent
      ? const Color(0xFFEF5369)
      : const Color(0xFF737B90);

  final background = isPresent
      ? const Color(0xFFE8F8EF)
      : isAbsent
      ? const Color(0xFFFFEEF1)
      : const Color(0xFFF0F1F5);

  final status = isPresent
      ? 'Present'
      : isAbsent
      ? 'Absent'
      : 'Unknown';

  final statusBadge = Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 9,
      vertical: 6,
    ),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isPresent
              ? Icons.check_circle
              : isAbsent
              ? Icons.cancel
              : Icons.help_outline,
          size: 15,
          color: color,
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: const Color(0xFFE6E8F0),
      ),
    ),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 290 ||
            MediaQuery.textScalerOf(context).scale(14) > 18;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _StudentAvatar(imageUrl: user?.profileImage),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? 'Unknown student',
                    style: const TextStyle(
                      color: Color(0xFF202329),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Roll number: ${user?.rollNumber ?? '—'}',
                    style: const TextStyle(
                      color: Color(0xFF737B90),
                      fontSize: 13,
                    ),
                  ),
                  if (compact) ...[
                    const SizedBox(height: 8),
                    statusBadge,
                  ],
                ],
              ),
            ),
            if (!compact) ...[
              const SizedBox(width: 10),
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
          width: 46,
          height: 46,
          child: url == null || url.isEmpty
              ? _fallback()
              : Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _fallback(),
            loadingBuilder: (_, child, progress) {
              return progress == null ? child : _fallback();
            },
          ),
        ),
      ),
    );
  }
}