import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:pabulum_teacher/bloc/dashboard/dashboard_bloc.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/screen/teaching_tools_section.dart';
import 'package:pabulum_teacher/utils/constants.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const _navy = Color(0xFF192841);
  static const _purple = Color(0xFF7655E8);
  static const _muted = Color(0xFF68738B);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (_) => DashboardBloc()..add(OnLoadDashboardData()),
      child: StreamBuilder<DateTime>(
        initialData: DateTime.now(),
        stream: Stream<DateTime>.periodic(
          const Duration(minutes: 1),
              (_) => DateTime.now(),
        ),
        builder: (context, clockSnapshot) {
          final now = clockSnapshot.data ?? DateTime.now();

          return BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Scaffold(
                    backgroundColor: const Color(0xFFF5F2FC),
                    body: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFF0EBFC),
                            Color(0xFFF0F6FF),
                            Color(0xFFF2F8F3),
                          ],
                        ),
                      ),
                      child: SafeArea(
                        bottom: false,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(
                            16,
                            16,
                            16,
                            20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildHeader(state, now),
                              const SizedBox(height: 16),
                              _buildAttendance(context, state),
                              const SizedBox(height: 22),
                              _buildAnnouncementSection(context, state),
                              const SizedBox(height: 22),
                              _buildDashboardGrid(context),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Bottom navigation stays in your parent tab screen.
                  ),
                  if (state.isLoading) Utils.loaderBrier(),
                  if (state.isLoading) Utils.loaderWid(),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeader(DashboardState state, DateTime now) {
    final user = state.dashboardData?.user;

    final greeting = now.hour < 12
        ? 'Good morning ☀️'
        : now.hour < 17
        ? 'Good afternoon ☀️'
        : 'Good evening 🌙';

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFECE5FC),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12765AB5),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: CustomPaint(
          painter: _DashboardHeaderPainter(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greeting,
                            style: const TextStyle(
                              color: Color(0xFF353052),
                              fontSize: 14,
                              height: 1.3,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _displayText(user?.name),
                            softWrap: true,
                            style: const TextStyle(
                              color: Color(0xFF131C42),
                              fontSize: 21,
                              height: 1.2,
                              letterSpacing: -0.4,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    _buildTeacherAvatar(user?.profileImage),
                  ],
                ),
                const SizedBox(height: 5),
                _buildSchoolAndClass(state, now),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeacherAvatar(String? imageUrl) {
    final url = imageUrl?.trim() ?? '';

    const fallback = ColoredBox(
      color: Color(0xFFE5E3EF),
      child: Center(
        child: Icon(
          Icons.person_rounded,
          color: Color(0xFF989BAB),
          size: 39,
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withAlpha(160),
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      child: ClipOval(
        child: SizedBox(
          width: 46,
          height: 46,
          child: url.isEmpty
              ? fallback
              : Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => fallback,
          ),
        ),
      ),
    );
  }

  Widget _buildSchoolAndClass(
      DashboardState state,
      DateTime now,
      ) {
    final school = state.dashboardData?.user?.school;

    return LayoutBuilder(
      builder: (context, constraints) {
        final largeText =
            MediaQuery.textScalerOf(context).scale(13) > 19;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

               Padding(
                    padding: const EdgeInsets.only(
                      top: 4,
                      bottom: 8,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSchoolImage(school?.profileImage),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _displayText(school?.name),
                                softWrap: true,
                                style: const TextStyle(
                                  color: Color(0xFF252C50),
                                  fontSize: 13,
                                  height: 1.35,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat(
                                  'EEE, d MMM • h:mm a',
                                ).format(now),
                                softWrap: true,
                                style: const TextStyle(
                                  color: Color(0xFF606985),
                                  fontSize: 10.5,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),



            _buildClassTeacherCard(state),
          ],
        );
      },
    );
  }

  Widget _buildSchoolImage(String? imageUrl) {
    final url = imageUrl?.trim() ?? '';

    const fallback = Center(
      child: Text(
        '🏫',
        style: TextStyle(fontSize: 26),
      ),
    );

    return SizedBox(
      width: 30,
      height: 32,
      child: url.isEmpty
          ? fallback
          : ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => fallback,
        ),
      ),
    );
  }

  Widget _buildClassTeacherCard(DashboardState state) {
    final data = state.dashboardData;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(65),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withAlpha(150),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.groups_rounded,
            color: Color(0xFF713DE5),
            size: 27,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Class teacher · ${data?.user?.classTeacherOf ?? '—'}',
                  softWrap: true,
                  style: const TextStyle(
                    color: Color(0xFF242743),
                    fontSize: 12,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${data?.myStudentsCount ?? '—'} students',
                  style: const TextStyle(
                    color: Color(0xFF626783),
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendance(
      BuildContext context,
      DashboardState state,
      ) {
    final data = state.dashboardData;
    final markedToday = Utils.isToday(data?.attendanceDate);

    final status = data == null
        ? '—'
        : markedToday
        ? 'Recorded'
        : 'Not marked';

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEAF9F3),
            Color(0xFFE3F3F3),
          ],
        ),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFCFE8DC),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D20836B),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              const heading = Row(
                children: [
                  Text('📋', style: TextStyle(fontSize: 25)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Today’s attendance',
                      style: TextStyle(
                        color: _navy,
                        fontSize: 16,
                        height: 1.3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              );

              final chip = Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: markedToday
                      ? const Color(0xFFCDEBD9)
                      : const Color(0xFFFFE7AB),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: markedToday
                        ? const Color(0xFF17724F)
                        : const Color(0xFF885511),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );

              final stack = constraints.maxWidth < 310 ||
                  MediaQuery.textScalerOf(context).scale(14) > 18;

              if (stack) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading,
                    const SizedBox(height: 8),
                    chip,
                  ],
                );
              }

              return Row(
                children: [
                  const Expanded(child: heading),
                  const SizedBox(width: 8),
                  chip,
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final tiles = [
                _buildAttendanceCount(
                  label: 'Total',
                  value: '${data?.myStudentsCount ?? '—'}',
                  icon: Icons.groups_rounded,
                  color: const Color(0xFF6951BD),
                  background: const Color(0xFFE6DDFB),
                ),
                _buildAttendanceCount(
                  label: 'Present',
                  value: markedToday
                      ? '${data?.presentCount ?? '—'}'
                      : '0',
                  icon: Icons.person_rounded,
                  color: const Color(0xFF188465),
                  background: const Color(0xFFD6F0E2),
                ),
                _buildAttendanceCount(
                  label: 'Absent',
                  value: markedToday
                      ? '${data?.absentCount ?? '—'}'
                      : '0',
                  icon: Icons.person_outline_rounded,
                  color: const Color(0xFFBD536A),
                  background: const Color(0xFFF8DEE5),
                ),
              ];

              final stack = constraints.maxWidth < 240 ||
                  MediaQuery.textScalerOf(context).scale(12) > 19;

              if (stack) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    tiles[0],
                    const SizedBox(height: 8),
                    tiles[1],
                    const SizedBox(height: 8),
                    tiles[2],
                  ],
                );
              }

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: tiles[0]),
                    const SizedBox(width: 8),
                    Expanded(child: tiles[1]),
                    const SizedBox(width: 8),
                    Expanded(child: tiles[2]),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(
                RouteName.attendanceHistoryScreen,
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: _purple,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            icon: const Icon(
              Icons.event_available_rounded,
              size: 21,
            ),
            label: const Text(
              'Open attendance',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCount({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    required Color background,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF596680),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 7),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 6,
            children: [
              Icon(icon, size: 20, color: color),
              Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementSection(
      BuildContext context,
      DashboardState state,
      ) {
    final announcement = state.dashboardData?.announcement;
    final description = announcement?.description?.trim() ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          '📣 Announcements',
          style: TextStyle(
            color: _navy,
            fontSize: 21,
            letterSpacing: -0.4,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0E5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFF0D7C3),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0FB97539),
                blurRadius: 16,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            clipBehavior: Clip.antiAlias,
            child: announcement == null
                ? const Padding(
              padding: EdgeInsets.all(18),
              child: Text(
                'No announcements',
                style: TextStyle(
                  color: _muted,
                  fontSize: 13,
                ),
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  color: const Color(0xFFFBDDC5),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.campaign_rounded,
                        color: Color(0xFFB66B35),
                        size: 27,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _displayText(announcement.title),
                          softWrap: true,
                          style: const TextStyle(
                            color: _navy,
                            fontSize: 15,
                            height: 1.4,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (description.isNotEmpty) ...[
                        AnimatedSize(
                          duration: const Duration(
                            milliseconds: 220,
                          ),
                          alignment: Alignment.topLeft,
                          curve: Curves.easeInOut,
                          child: Text(
                            description,
                            maxLines: state.isExpanded ? null : 3,
                            overflow: state.isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF655E5A),
                              fontSize: 14,
                              height: 1.6,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(145),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Color(0xFFB76A32),
                              size: 21,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Announcement period',
                                    style: TextStyle(
                                      color: Color(0xFF8B7567),
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    Utils.period(
                                      announcement.startDate,
                                      announcement.endDate,
                                    ),
                                    softWrap: true,
                                    style: const TextStyle(
                                      color: _navy,
                                      fontSize: 12,
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const Divider(
                    height: 1,
                    color: Color(0xFFF0D7C3),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<DashboardBloc>().add(
                        OnExpandClick(),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF9B5829),
                      minimumSize: const Size.fromHeight(48),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.isExpanded ? 'Show less' : 'Read more',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          state.isExpanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 21,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardGrid(BuildContext context) {
    return TeachingToolsSection(
      onToolTap: (tool) {
        final route = switch (tool) {
          TeacherTool.attendance => RouteName.attendanceHistoryScreen,
          TeacherTool.students => RouteName.myStudentScreen,
          TeacherTool.assignments => RouteName.homeworkScreen,
          TeacherTool.submittedHomework => RouteName.submittedHomeworkScreen,
          TeacherTool.classwork => RouteName.classworkScreen,
          TeacherTool.assignedClasses => RouteName.assignedClassScreen,
          TeacherTool.timetable => RouteName.timetableScreen,
          TeacherTool.studentOrders => RouteName.studentProduct,
        };

        Navigator.of(context).pushNamed(route);
      },
    );
  }

  String _displayText(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? '—' : text;
  }
}

// This is a painter, not a separate header widget.
// CustomPaint uses it to draw the curved background.
class _DashboardHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final backgroundPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFE6D9FC),
          Color(0xFFD7DAFC),
          Color(0xFFBED6FC),
        ],
        stops: [0, 0.48, 1],
      ).createShader(rect);

    canvas.drawRect(rect, backgroundPaint);

    final wave = Path()
      ..moveTo(0, size.height * 0.65)
      ..cubicTo(
        size.width * 0.17,
        size.height * 0.43,
        size.width * 0.35,
        size.height * 0.84,
        size.width * 0.56,
        size.height * 0.58,
      )
      ..cubicTo(
        size.width * 0.74,
        size.height * 0.25,
        size.width * 0.83,
        size.height * 0.62,
        size.width,
        size.height * 0.37,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(
      wave,
      Paint()..color = Colors.white.withAlpha(55),
    );

    final lowerWave = Path()
      ..moveTo(0, size.height * 0.85)
      ..cubicTo(
        size.width * 0.24,
        size.height * 0.59,
        size.width * 0.40,
        size.height * 0.99,
        size.width * 0.64,
        size.height * 0.73,
      )
      ..cubicTo(
        size.width * 0.78,
        size.height * 0.55,
        size.width * 0.88,
        size.height * 0.91,
        size.width,
        size.height * 0.66,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(
      lowerWave,
      Paint()..color = const Color(0xFFBCA9F4).withAlpha(35),
    );
  }

  @override
  bool shouldRepaint(covariant _DashboardHeaderPainter oldDelegate) {
    return false;
  }
}