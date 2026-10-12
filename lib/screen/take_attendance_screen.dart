
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/attendance/attendance_bloc.dart';
import 'package:pabulum_teacher/bloc/my_student/my_student_bloc.dart';
import 'package:pabulum_teacher/model/my_students.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class TakeAttendanceScreen extends StatelessWidget {
  const TakeAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AttendanceBloc>(
            create: (_) => AttendanceBloc(),
          ),
          BlocProvider<MyStudentBloc>(
            create: (_) => MyStudentBloc()
              ..add(
                OnLoadMyStudents(),
              ),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<MyStudentBloc, MyStudentState>(
              listenWhen: (previous, current) {
                return previous.arrMyStudents.isEmpty &&
                    current.arrMyStudents.isNotEmpty;
              },
              listener: (context, studentState) {
                final attendanceBloc =
                context.read<AttendanceBloc>();

                if (attendanceBloc
                    .state.attendanceStatus.isEmpty) {
                  attendanceBloc.add(
                    AttendanceEvent.onMarkAllAttendance(
                      isPresent: true,
                      students: studentState.arrMyStudents,
                    ),
                  );
                }
              },
            ),
            BlocListener<AttendanceBloc, AttendanceState>(
              listenWhen: (previous, current) =>
              !previous.isSubmitted &&
                  current.isSubmitted,
              listener: (context, state) {
                Navigator.of(context).pop(true);
              },
            ),
          ],
          child: BlocBuilder<MyStudentBloc, MyStudentState>(
            builder: (context, studentState) {
              final students = studentState.arrMyStudents;

              return BlocBuilder<AttendanceBloc,
                  AttendanceState>(
                builder: (context, state) {
                  final busy =
                      state.isLoading || state.isSubmitting;

                  final total = students.length;

                  final present = students.where((student) {
                    return state.attendanceStatus[
                    student.id.toString()] ==
                        true;
                  }).length;

                  final absent = total - present;

                  final allPresent =
                      students.isNotEmpty && present == total;

                  final allAbsent =
                      students.isNotEmpty && absent == total;

                  return PopScope(
                    canPop: !state.isSubmitting,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            AppImages.icBackground,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SafeArea(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ConstrainedBox(
                              constraints:
                              const BoxConstraints(
                                maxWidth: 700,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: CustomAppBar(
                                      title: 'Take attendance',
                                      subtitle:
                                      'Mark attendance for\nyour students',
                                      image:
                                      AppImages.icAttendanceDetailHeader,
                                      onBack: () {
                                        if (!state.isSubmitting) {
                                          Navigator.of(context)
                                              .maybePop();
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: _buildAttendancePanel(
                                      context,
                                      state,
                                      total,
                                      present,
                                      absent,
                                      busy,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 18,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Students',
                                            style: TextStyle(
                                              color: AppColors.ink,
                                              fontSize: 20,
                                              fontWeight:
                                              FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: _BulkAttendanceButton(
                                            label: 'All present',
                                            icon:
                                            Icons.check_circle,
                                            isSelected: allPresent,
                                            color:
                                            AppColors.green,
                                            background:
                                            AppColors.softBlue,
                                            enabled: !busy &&
                                                students.isNotEmpty,
                                            onPressed: () {
                                              context
                                                  .read<
                                                  AttendanceBloc>()
                                                  .add(
                                                AttendanceEvent
                                                    .onMarkAllAttendance(
                                                  isPresent: true,
                                                  students: students,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 9),
                                        Expanded(
                                          child: _BulkAttendanceButton(
                                            label: 'All absent',
                                            icon: Icons.cancel,
                                            isSelected: allAbsent,
                                            color: AppColors.red,
                                            background:
                                            AppColors.softPink,
                                            enabled: !busy &&
                                                students.isNotEmpty,
                                            onPressed: () {
                                              context
                                                  .read<
                                                  AttendanceBloc>()
                                                  .add(
                                                AttendanceEvent
                                                    .onMarkAllAttendance(
                                                  isPresent: false,
                                                  students: students,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Expanded(
                                    child: students.isEmpty
                                        ? _emptyStudentsView()
                                        : ListView.builder(
                                      padding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      itemCount:
                                      students.length,
                                      itemBuilder:
                                          (context, index) {
                                        final student =
                                        students[index];

                                        final studentId =
                                        student.id
                                            .toString();

                                        final isPresent =
                                            state.attendanceStatus[
                                            studentId] ==
                                                true;

                                        return Padding(
                                          padding:
                                          const EdgeInsets.only(
                                            bottom: 9,
                                          ),
                                          child:
                                          _TakeAttendanceCard(
                                            key: ValueKey(
                                              student.id,
                                            ),
                                            student: student,
                                            isPresent:
                                            isPresent,
                                            onChanged: busy
                                                ? null
                                                : (value) {
                                              context
                                                  .read<
                                                  AttendanceBloc>()
                                                  .add(
                                                AttendanceEvent
                                                    .onChangeStudentAttendance(
                                                  studentId:
                                                  studentId,
                                                  isPresent:
                                                  value,
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(
                                      16,
                                      8,
                                      16,
                                      12,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          '$present present · $absent absent',
                                          style: TextStyle(
                                            color: AppColors.muted,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        _buildSubmitButton(
                                          context,
                                          students,
                                          busy,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (busy) Utils.loaderBrier(),
                        if (busy) Utils.loaderWid(),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAttendancePanel(
      BuildContext context,
      AttendanceState state,
      int total,
      int present,
      int absent,
      bool busy,
      ) {
    return _AttendancePanel(
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: busy
                ? null
                : () => _selectDate(
              context,
              state.attendanceDate,
            ),
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
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
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attendance date',
                        style: TextStyle(
                          color: AppColors.muted,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _displayDate(state.attendanceDate),
                        style: TextStyle(
                          color: AppColors.ink,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        _getWeekday(state.attendanceDate),
                        style: TextStyle(
                          color: AppColors.muted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.purple,
                  size: 26,
                ),
              ],
            ),
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              Expanded(
                child: _count(
                  'Total',
                  total,
                  AppColors.purple,
                  AppColors.lavender,
                  Icons.groups_rounded,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _count(
                  'Present',
                  present,
                  AppColors.green,
                  AppColors.softBlue,
                  Icons.person_rounded,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _count(
                  'Absent',
                  absent,
                  AppColors.red,
                  AppColors.softPink,
                  Icons.person_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _count(
      String label,
      int value,
      Color color,
      Color background,
      IconData icon,
      ) {
    return Container(
      height: 74,
      decoration: BoxDecoration(
        color: background.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 22,
          ),
          const SizedBox(width: 5),
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
                '$value',
                style: TextStyle(
                  color: color,
                  fontSize: 23,
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

  Widget _buildSubmitButton(
      BuildContext context,
      List<MyStudent> students,
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
            color: AppColors.purple.withValues(alpha: 0.22),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: busy || students.isEmpty
              ? null
              : () {
            context.read<AttendanceBloc>().add(
              AttendanceEvent.onSubmitAttendance(
                students: students,
              ),
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
                'Submit attendance',
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

  Widget _emptyStudentsView() {
    return Center(
      child: Text(
        'No students available.',
        style: TextStyle(
          color: AppColors.muted,
          fontSize: 13,
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context,
      DateTime selectedDate,
      ) async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateUtils.dateOnly(DateTime.now()),
    );

    if (date != null && context.mounted) {
      context.read<AttendanceBloc>().add(
        AttendanceEvent.onChangeAttendanceDate(
          date: date,
        ),
      );
    }
  }

  String _displayDate(DateTime date) {
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

  String _getWeekday(DateTime date) {
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
}

class _AttendancePanel extends StatelessWidget {
  const _AttendancePanel({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: AppColors.colorGrey1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _BulkAttendanceButton extends StatelessWidget {
  const _BulkAttendanceButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.color,
    required this.background,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final Color color;
  final Color background;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: enabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        backgroundColor: isSelected
            ? background
            : AppColors.surface,
        disabledForegroundColor: AppColors.muted,
        minimumSize: const Size(0, 54),
        padding: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 8,
        ),
        side: BorderSide(
          color: isSelected
              ? color.withValues(alpha: 0.4)
              : AppColors.colorGrey1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      icon: Icon(
        icon,
        color: color,
        size: 19,
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _TakeAttendanceCard extends StatelessWidget {
  const _TakeAttendanceCard({
    super.key,
    required this.student,
    required this.isPresent,
    required this.onChanged,
  });

  final MyStudent student;
  final bool isPresent;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
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
      child: Row(
        children: [
          _StudentAvatar(
            imageUrl: student.profileImage,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  student.name ?? '—',
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
                  'Roll number: ${student.rollNumber ?? '—'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: isPresent,
                onChanged: onChanged == null
                    ? null
                    : (value) {
                  onChanged!(value ?? false);
                },
                activeColor: AppColors.purple,
                checkColor: AppColors.white,
                side: BorderSide(
                  color: AppColors.purple,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              Text(
                isPresent ? 'Present' : 'Absent',
                style: TextStyle(
                  color: isPresent
                      ? AppColors.purple
                      : AppColors.red,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StudentAvatar extends StatelessWidget {
  const _StudentAvatar({
    this.imageUrl,
  });

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

    return ClipOval(
      child: SizedBox(
        width: 52,
        height: 52,
        child: url == null || url.isEmpty
            ? _fallback()
            : Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _fallback(),
          loadingBuilder: (_, child, progress) {
            return progress == null
                ? child
                : _fallback();
          },
        ),
      ),
    );
  }
}
