import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/attendance/attendance_bloc.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: Utils.customAppBar(
        'Attendance',
        context,
        isBack: true,
        onBackPress: () {
          Navigator.of(context).pop();
        },
      ),
      body: BlocProvider(
        create: (context) => AttendanceBloc()
          ..add(
            const AttendanceEvent.onLoadAttendanceHistory(page: 1),
          ),
        child: BlocBuilder<AttendanceBloc, AttendanceState>(
          builder: (context, state) {
            final records = state.arrAttendanceHistory;
            final busy = state.isLoading || state.isLoadingMore;

            return Stack(
              children: [
                SafeArea(
                  top: false,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Column(
                        children: [
                          // Fixed header and date filter.
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(20, 24, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'View and manage attendance records',
                                  style: TextStyle(
                                    color: Color(0xFF737B90),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                Material(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    side: const BorderSide(
                                      color: Color(0xFFE4E7EF),
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: InkWell(
                                    onTap: busy
                                        ? null
                                        : () => _selectDate(
                                      context,
                                      state.filterDate,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          const _CalendarIcon(),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              state.filterDate == null
                                                  ? 'Filter by date'
                                                  : _formatDate(
                                                state.filterDate!,
                                              ),
                                              style: TextStyle(
                                                color: state.filterDate == null
                                                    ? const Color(0xFF737B90)
                                                    : const Color(0xFF202329),
                                                fontSize: 15,
                                                fontWeight:
                                                state.filterDate == null
                                                    ? FontWeight.normal
                                                    : FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          if (state.filterDate != null)
                                            IconButton(
                                              tooltip: 'Clear date',
                                              onPressed: busy
                                                  ? null
                                                  : () {
                                                context
                                                    .read<
                                                    AttendanceBloc>()
                                                    .add(
                                                  const AttendanceEvent
                                                      .onLoadAttendanceHistory(
                                                    page: 1,
                                                    date: null,
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.close_rounded,
                                                color: Color(0xFF737B90),
                                              ),
                                            )
                                          else
                                            const Icon(
                                              Icons.chevron_right_rounded,
                                              color: Color(0xFF737B90),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Attendance history',
                                        style: TextStyle(
                                          color: Color(0xFF202329),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    if (!state.isLoading &&
                                        records.isNotEmpty)
                                      Text(
                                        '${records.length} records',
                                        style: const TextStyle(
                                          color: Color(0xFF737B90),
                                          fontSize: 13,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 18),
                              ],
                            ),
                          ),

                          // Only the list scrolls.
                          Expanded(
                            child: records.isEmpty
                                ? state.isLoading
                                ? const SizedBox.shrink()
                                : _buildEmptyState(context, state)
                                : ListView.builder(
                              padding: const EdgeInsets.fromLTRB(
                                20,
                                0,
                                20,
                                24,
                              ),
                              itemCount: records.length + 1,
                              itemBuilder: (context, index) {
                                // Last item is the pagination footer.
                                if (index == records.length) {
                                  return _buildPagination(
                                    context,
                                    state,
                                  );
                                }

                                final record = records[index];

                                return Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: 14),
                                  child: _AttendanceHistoryCard(
                                    key: ValueKey(record.id),
                                    date: record.date ?? '—',
                                    present: record.presentCount ?? 0,
                                    absent: record.absentCount ?? 0,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteName.attendanceDetailScreen,
                                        arguments: record.id,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),

                          // Fixed bottom button.
                          Container(
                            width: double.infinity,
                            padding:
                            const EdgeInsets.fromLTRB(20, 12, 20, 12),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(
                                  color: Color(0xFFE6E8F0),
                                ),
                              ),
                            ),
                            child: FilledButton.icon(
                              onPressed: busy
                                  ? null
                                  : () {
                                Navigator.pushNamed(context, RouteName.takeAttendanceScreen);
                              },
                              icon: const Icon(
                                Icons.event_available_outlined,
                              ),
                              label: const Text(
                                'Take attendance',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF704CFF),
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(52),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Your existing loading overlay.
                if (state.isLoading) Utils.loaderBrier(),
                if (state.isLoading) Utils.loaderWid(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(
      BuildContext context,
      AttendanceState state,
      ) {

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text('No attendance records',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF202329),
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(
      BuildContext context,
      AttendanceState state,
      ) {
    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF704CFF),
          ),
        ),
      );
    }


    if (!state.hasMore) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          'All records loaded',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF737B90),
            fontSize: 12,
          ),
        ),
      );
    }

    return Center(
      child: OutlinedButton(
        onPressed: () => _loadMore(context, state),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF704CFF),
          side: const BorderSide(
            color: Color(0xFF704CFF),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
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
    if (state.isLoading || state.isLoadingMore || !state.hasMore) {
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
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    return '${date.day.toString().padLeft(2, '0')} '
        '${months[date.month - 1]} ${date.year}';
  }
}

class _AttendanceHistoryCard extends StatelessWidget {
  const _AttendanceHistoryCard({
    super.key,
    required this.date,
    required this.present,
    required this.absent,
    this.onTap,
  });

  final String date;
  final num present;
  final num absent;
  final VoidCallback? onTap;

  String _displayDate(String value) {
    // Supports API dates in dd-MM-yyyy or yyyy-MM-dd format.
    final parts = value.trim().split('-');

    if (parts.length != 3) return value;

    final yearFirst = parts.first.length == 4;

    final day = int.tryParse(yearFirst ? parts[2] : parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(yearFirst ? parts[0] : parts[2]);

    if (day == null || month == null || year == null) {
      return value;
    }

    final parsed = DateTime(year, month, day);

    if (parsed.year != year ||
        parsed.month != month ||
        parsed.day != day) {
      return value;
    }

    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    return '${day.toString().padLeft(2, '0')} '
        '${months[month - 1]} $year';
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF704CFF);
    const radius = BorderRadius.all(Radius.circular(14));

    final total = present + absent;
    final progress = total > 0
        ? (present / total).clamp(0.0, 1.0).toDouble()
        : 0.0;

    final percentage =
    total > 0 ? '${(progress * 100).round()}%' : '—';

    // Allow the indicator to grow with accessibility text settings.
    final scaledLabelSize = MediaQuery.textScalerOf(context).scale(12);
    final ringSize = 52.0 + (scaledLabelSize - 12).clamp(0.0, 36.0) * 2;

    return Material(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: Color(0xFFE6E8F0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: const Color(0x145746FF),
        highlightColor: const Color(0x085746FF),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: purple,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _displayDate(date),
                            style: const TextStyle(
                              color: Color(0xFF202329),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '${present.toStringAsFixed(0)} present',
                          style: const TextStyle(
                            color: Color(0xFF159654),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          '·',
                          style: TextStyle(
                            color: Color(0xFF9399AA),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${absent.toStringAsFixed(0)} absent',
                          style: const TextStyle(
                            color: Color(0xFFEF5369),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),

              // Circular attendance progress.
              Semantics(
                label: 'Attendance',
                value: total > 0 ? percentage : 'No students',
                child: ExcludeSemantics(
                  child: SizedBox(
                    width: ringSize,
                    height: ringSize,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 4,
                              strokeCap: StrokeCap.round,
                              color: purple,
                              backgroundColor:
                              const Color(0xFFEDE7FF),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              percentage,
                              style: const TextStyle(
                                color: purple,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              if (onTap != null) ...[
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF9CA3B4),
                  size: 22,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
class _CalendarIcon extends StatelessWidget {
  const _CalendarIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EBFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.calendar_month_outlined,
        color: Color(0xFF704CFF),
        size: 23,
      ),
    );
  }
}

