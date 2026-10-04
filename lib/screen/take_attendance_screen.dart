import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/attendance/attendance_bloc.dart';
import 'package:pabulum_teacher/bloc/my_student/my_student_bloc.dart';
import 'package:pabulum_teacher/model/my_students.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class TakeAttendanceScreen extends StatelessWidget {
  const TakeAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      appBar: Utils.customAppBar(
        'Take attendance',
        context,
        isBack: true,
        onBackPress: () {
          Navigator.of(context).maybePop();
        },
      ),

      body: MultiBlocProvider(
        providers: [
          // ===============================================================
          // ATTENDANCE BLOC
          // ===============================================================

          BlocProvider<AttendanceBloc>(
            create: (_) => AttendanceBloc(),
          ),

          // ===============================================================
          // MY STUDENT BLOC
          // ===============================================================

          BlocProvider<MyStudentBloc>(
            create: (_) => MyStudentBloc()
              ..add(
                OnLoadMyStudents(),
              ),
          ),
        ],

        child: MultiBlocListener(
          listeners: [
            // =============================================================
            // DEFAULT: ALL PRESENT
            // =============================================================

            BlocListener<MyStudentBloc, MyStudentState>(
              listenWhen: (previous, current) {
                return previous.arrMyStudents.isEmpty &&
                    current.arrMyStudents.isNotEmpty;
              },

              listener: (context, studentState) {
                final attendanceBloc =
                context.read<AttendanceBloc>();

                // Only initialise attendance if it has not
                // already been initialised.
                if (attendanceBloc
                    .state
                    .attendanceStatus
                    .isEmpty) {
                  attendanceBloc.add(
                    AttendanceEvent.onMarkAllAttendance(
                      isPresent: true,
                      students: studentState.arrMyStudents,
                    ),
                  );
                }
              },
            ),

            // =============================================================
            // ATTENDANCE SUBMITTED
            // =============================================================

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

              return BlocBuilder<AttendanceBloc, AttendanceState>(
                builder: (context, state) {
                  // =======================================================
                  // BASIC STATE
                  // =======================================================

                  final busy =
                      state.isLoading ||
                          state.isSubmitting;

                  final total = students.length;

                  final present = students.where((student) {
                    return state.attendanceStatus[
                    student.id.toString()] ==
                        true;
                  }).length;

                  final absent = total - present;

                  // =======================================================
                  // BULK BUTTON STATE
                  // =======================================================

                  final allPresent =
                      students.isNotEmpty &&
                          present == total;

                  final allAbsent =
                      students.isNotEmpty &&
                          absent == total;

                  return PopScope(
                    canPop: !state.isSubmitting,

                    child: Stack(
                      children: [
                        // =================================================
                        // MAIN CONTENT
                        // =================================================

                        SafeArea(
                          top: false,

                          child: Align(
                            alignment: Alignment.topCenter,

                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 700,
                              ),

                              child: Column(
                                children: [
                                  // =======================================
                                  // HEADER
                                  // =======================================

                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(
                                      20,
                                      20,
                                      20,
                                      0,
                                    ),

                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                      children: [
                                        const Text(
                                          'Mark attendance for your students',

                                          style: TextStyle(
                                            color:
                                            Color(0xFF737B90),
                                            fontSize: 14,
                                          ),
                                        ),

                                        const SizedBox(height: 16),

                                        // =================================
                                        // DATE + COUNTERS
                                        // =================================

                                        _AttendancePanel(
                                          child: Column(
                                            children: [
                                              // =============================
                                              // ATTENDANCE DATE
                                              // =============================

                                              InkWell(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  12,
                                                ),

                                                onTap: busy
                                                    ? null
                                                    : () =>
                                                    _selectDate(
                                                      context,
                                                      state
                                                          .attendanceDate,
                                                    ),

                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(
                                                    2,
                                                  ),

                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(
                                                          10,
                                                        ),

                                                        decoration:
                                                        BoxDecoration(
                                                          color:
                                                          const Color(
                                                            0xFFF0EBFF,
                                                          ),

                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                            12,
                                                          ),
                                                        ),

                                                        child:
                                                        const Icon(
                                                          Icons
                                                              .calendar_month_outlined,

                                                          color:
                                                          Color(
                                                            0xFF704CFF,
                                                          ),
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                        width: 12,
                                                      ),

                                                      Expanded(
                                                        child:
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,

                                                          children: [
                                                            const Text(
                                                              'Attendance date',

                                                              style:
                                                              TextStyle(
                                                                color:
                                                                Color(
                                                                  0xFF737B90,
                                                                ),
                                                                fontSize:
                                                                12,
                                                              ),
                                                            ),

                                                            const SizedBox(
                                                              height: 4,
                                                            ),

                                                            Text(
                                                              _displayDate(
                                                                state
                                                                    .attendanceDate,
                                                              ),

                                                              style:
                                                              const TextStyle(
                                                                color:
                                                                Color(
                                                                  0xFF202329,
                                                                ),
                                                                fontSize:
                                                                16,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      const Icon(
                                                        Icons
                                                            .chevron_right_rounded,

                                                        color:
                                                        Color(
                                                          0xFF737B90,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(
                                                height: 16,
                                              ),

                                              const Divider(
                                                height: 1,
                                                color:
                                                Color(0xFFE6E8F0),
                                              ),

                                              const SizedBox(
                                                height: 16,
                                              ),

                                              // =============================
                                              // COUNTERS
                                              // =============================

                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: _count(
                                                      'Total',
                                                      total,
                                                      const Color(
                                                        0xFF202329,
                                                      ),
                                                    ),
                                                  ),

                                                  Expanded(
                                                    child: _count(
                                                      'Present',
                                                      present,
                                                      const Color(
                                                        0xFF159654,
                                                      ),
                                                    ),
                                                  ),

                                                  Expanded(
                                                    child: _count(
                                                      'Absent',
                                                      absent,
                                                      const Color(
                                                        0xFFEF5369,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 20),

                                        // =================================
                                        // STUDENTS TITLE
                                        // =================================

                                        const Text(
                                          'Students',

                                          style: TextStyle(
                                            color:
                                            Color(0xFF202329),
                                            fontSize: 19,
                                            fontWeight:
                                            FontWeight.w700,
                                          ),
                                        ),

                                        const SizedBox(height: 12),

                                        // =================================
                                        // ALL PRESENT / ALL ABSENT
                                        // =================================

                                        Row(
                                          children: [
                                            Expanded(
                                              child:
                                              _BulkAttendanceButton(
                                                label: 'All present',

                                                icon:
                                                Icons.check_circle,

                                                isSelected:
                                                allPresent,

                                                color:
                                                const Color(
                                                  0xFF159654,
                                                ),

                                                enabled:
                                                !busy &&
                                                    students.isNotEmpty,

                                                onPressed: () {
                                                  context
                                                      .read<
                                                      AttendanceBloc>()
                                                      .add(
                                                    AttendanceEvent
                                                        .onMarkAllAttendance(
                                                      isPresent:
                                                      true,
                                                      students:
                                                      students,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),

                                            const SizedBox(
                                              width: 12,
                                            ),

                                            Expanded(
                                              child:
                                              _BulkAttendanceButton(
                                                label: 'All absent',

                                                icon:
                                                Icons.cancel,

                                                isSelected:
                                                allAbsent,

                                                color:
                                                const Color(
                                                  0xFFEF5369,
                                                ),

                                                enabled:
                                                !busy &&
                                                    students.isNotEmpty,

                                                onPressed: () {
                                                  context
                                                      .read<
                                                      AttendanceBloc>()
                                                      .add(
                                                    AttendanceEvent
                                                        .onMarkAllAttendance(
                                                      isPresent:
                                                      false,
                                                      students:
                                                      students,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(
                                          height: 14,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // =======================================
                                  // STUDENT LIST
                                  // =======================================

                                  Expanded(
                                    child: students.isEmpty
                                        ? _emptyStudentsView()
                                        : ListView.builder(
                                      padding:
                                      const EdgeInsets.fromLTRB(
                                        20,
                                        0,
                                        20,
                                        20,
                                      ),

                                      itemCount:
                                      students.length,

                                      itemBuilder:
                                          (context, index) {
                                        final student =
                                        students[index];

                                        final studentId =
                                        student.id.toString();

                                        final isPresent =
                                            state.attendanceStatus[
                                            studentId] ==
                                                true;

                                        return Padding(
                                          padding:
                                          const EdgeInsets.only(
                                            bottom: 12,
                                          ),

                                          child:
                                          _TakeAttendanceCard(
                                            key: ValueKey(
                                              student.id,
                                            ),

                                            student:
                                            student,

                                            isPresent:
                                            isPresent,

                                            onChanged:
                                            busy
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

                                  // =======================================
                                  // SUBMIT SECTION
                                  // =======================================

                                  Container(
                                    width:
                                    double.infinity,

                                    padding:
                                    const EdgeInsets.fromLTRB(
                                      20,
                                      12,
                                      20,
                                      12,
                                    ),

                                    decoration:
                                    const BoxDecoration(
                                      color: Colors.white,

                                      border: Border(
                                        top: BorderSide(
                                          color:
                                          Color(0xFFE6E8F0),
                                        ),
                                      ),
                                    ),

                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .stretch,

                                      children: [
                                        Text(
                                          '$present present · '
                                              '$absent absent',

                                          style:
                                          const TextStyle(
                                            color:
                                            Color(0xFF737B90),
                                            fontSize: 13,
                                          ),
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),

                                        FilledButton(
                                          onPressed:
                                          busy ||
                                              students.isEmpty
                                              ? null
                                              : () {
                                            context
                                                .read<
                                                AttendanceBloc>()
                                                .add(
                                              AttendanceEvent
                                                  .onSubmitAttendance(
                                                students:
                                                students,
                                              ),
                                            );
                                          },

                                          style:
                                          FilledButton.styleFrom(
                                            backgroundColor:
                                            const Color(
                                              0xFF704CFF,
                                            ),

                                            foregroundColor:
                                            Colors.white,

                                            minimumSize:
                                            const Size
                                                .fromHeight(
                                              52,
                                            ),

                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                12,
                                              ),
                                            ),
                                          ),

                                          child:
                                          const Text(
                                            'Submit attendance',

                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight:
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // =================================================
                        // LOADING
                        // =================================================

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

  // ========================================================================
  // EMPTY STUDENTS
  // ========================================================================

  Widget _emptyStudentsView() {
    return const Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Text(
              'No students available.',

              style: TextStyle(
                color: Color(0xFF737B90),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================================================================
  // DATE PICKER
  // ========================================================================

  Future<void> _selectDate(
      BuildContext context,
      DateTime selectedDate,
      ) async {
    final date = await showDatePicker(
      context: context,

      initialDate: selectedDate,

      firstDate: DateTime(2000),

      lastDate:
      DateUtils.dateOnly(DateTime.now()),
    );

    if (date != null && context.mounted) {
      context.read<AttendanceBloc>().add(
        AttendanceEvent.onChangeAttendanceDate(
          date: date,
        ),
      );
    }
  }

  // ========================================================================
  // DATE DISPLAY
  // ========================================================================

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

  // ========================================================================
  // COUNTER
  // ========================================================================

  Widget _count(
      String label,
      int value,
      Color color,
      ) {
    return Column(
      children: [
        Text(
          label,

          style: const TextStyle(
            color: Color(0xFF737B90),
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          '$value',

          style: TextStyle(
            color: color,
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ==========================================================================
// ATTENDANCE PANEL
// ==========================================================================

class _AttendancePanel extends StatelessWidget {
  const _AttendancePanel({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),

        side: const BorderSide(
          color: Color(0xFFE6E8F0),
        ),
      ),

      clipBehavior: Clip.antiAlias,

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

// ==========================================================================
// BULK ATTENDANCE BUTTON
// ==========================================================================

class _BulkAttendanceButton extends StatelessWidget {
  const _BulkAttendanceButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.color,
    required this.enabled,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final Color color;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed:
      enabled ? onPressed : null,

      style: OutlinedButton.styleFrom(
        foregroundColor:
        isSelected
            ? Colors.white
            : color,

        backgroundColor:
        isSelected
            ? color
            : Colors.white,

        disabledForegroundColor:
        const Color(0xFFB9BDCA),

        disabledBackgroundColor:
        const Color(0xFFF2F3F7),

        minimumSize:
        const Size(0, 48),

        padding:
        const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),

        side: BorderSide(
          color: isSelected
              ? color
              : const Color(0xFFE0E3EE),
        ),

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(12),
        ),
      ),

      icon: Icon(
        icon,

        color: isSelected
            ? Colors.white
            : color,

        size: 19,
      ),

      label: Text(
        label,

        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ==========================================================================
// STUDENT ATTENDANCE CARD
// ==========================================================================

class _TakeAttendanceCard
    extends StatelessWidget {
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
    return _AttendancePanel(
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,

        children: [
          // ================================================================
          // STUDENT IMAGE
          // ================================================================

          _StudentAvatar(
            imageUrl:
            student.profileImage,
          ),

          const SizedBox(width: 12),

          // ================================================================
          // NAME + ROLL NUMBER
          // ================================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  student.name ?? '—',

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style:
                  const TextStyle(
                    color:
                    Color(0xFF202329),

                    fontSize: 16,

                    fontWeight:
                    FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Roll number: '
                      '${student.rollNumber ?? '—'}',

                  style:
                  const TextStyle(
                    color:
                    Color(0xFF737B90),

                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // ================================================================
          // PRESENT CHECKBOX
          // ================================================================

          Column(
            mainAxisSize:
            MainAxisSize.min,

            children: [
              Checkbox(
                value: isPresent,

                onChanged:
                onChanged == null
                    ? null
                    : (value) {
                  onChanged!(
                    value ?? false,
                  );
                },

                activeColor:
                const Color(
                  0xFF159654,
                ),

                checkColor:
                Colors.white,

                materialTapTargetSize:
                MaterialTapTargetSize
                    .shrinkWrap,

                visualDensity:
                VisualDensity.compact,
              ),

              Text(
                'Present',

                style: TextStyle(
                  color: isPresent
                      ? const Color(
                    0xFF159654,
                  )
                      : const Color(
                    0xFF737B90,
                  ),

                  fontSize: 11,

                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================================================
// STUDENT AVATAR
// ==========================================================================

class _StudentAvatar
    extends StatelessWidget {
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
    final url =
    imageUrl?.trim();

    return ClipOval(
      child: SizedBox(
        width: 48,
        height: 48,

        child:
        url == null ||
            url.isEmpty
            ? _fallback()
            : Image.network(
          url,

          fit: BoxFit.cover,

          errorBuilder:
              (_, __, ___) =>
              _fallback(),

          loadingBuilder:
              (
              _,
              child,
              progress,
              ) {
            return progress ==
                null
                ? child
                : _fallback();
          },
        ),
      ),
    );
  }
}