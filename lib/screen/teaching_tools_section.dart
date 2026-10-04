import 'package:flutter/material.dart';
import 'package:pabulum_teacher/utils/constants.dart';

class TeachingToolsSection extends StatelessWidget {
  const TeachingToolsSection({
    super.key,
    required this.onToolTap,
  });

  final ValueChanged<TeacherTool> onToolTap;

  @override
  Widget build(BuildContext context) {
    final tiles = <Widget>[
      _buildTile(
        title: 'Students',
        icon: Icons.people_outline_rounded,
        color: const Color(0xFF2860CE),
        background: const Color(0xFFEEF4FF),
        iconBackground: const Color(0xFFDFEAFE),
        onTap: () => onToolTap(TeacherTool.students),
      ),
      _buildTile(
        title: 'Attendance',
        icon: Icons.how_to_reg_outlined,
        color: const Color(0xFF128267),
        background: const Color(0xFFEDF8F3),
        iconBackground: const Color(0xFFD9F0E6),
        onTap: () => onToolTap(TeacherTool.attendance),
      ),
      _buildTile(
        title: 'Assignments',
        icon: Icons.menu_book_rounded,
        color: const Color(0xFF7044D2),
        background: const Color(0xFFF5F0FE),
        iconBackground: const Color(0xFFE9DEFC),
        onTap: () => onToolTap(TeacherTool.assignments),
      ),
      _buildTile(
        title: 'Submitted Homework',
        icon: Icons.task_outlined,
        color: const Color(0xFFBE622B),
        background: const Color(0xFFFFF3EB),
        iconBackground: const Color(0xFFFBE3D2),
        onTap: () => onToolTap(TeacherTool.submittedHomework),
      ),
      _buildTile(
        title: 'Classwork',
        icon: Icons.assignment_outlined,
        color: const Color(0xFF4561CE),
        background: const Color(0xFFF0F3FF),
        iconBackground: const Color(0xFFE1E7FE),
        onTap: () => onToolTap(TeacherTool.classwork),
      ),
      _buildTile(
        title: 'Assigned Classes',
        icon: Icons.groups_outlined,
        color: const Color(0xFF7550CD),
        background: const Color(0xFFF5F0FD),
        iconBackground: const Color(0xFFE9DFFB),
        onTap: () => onToolTap(TeacherTool.assignedClasses),
      ),
      _buildTile(
        title: 'Timetable',
        icon: Icons.more_time_rounded,
        color: const Color(0xFF087D87),
        background: const Color(0xFFEBF8F8),
        iconBackground: const Color(0xFFD8F0F0),
        onTap: () => onToolTap(TeacherTool.timetable),
      ),
      _buildTile(
        title: 'Student Orders',
        icon: Icons.inventory_2_outlined,
        color: const Color(0xFFB45C2B),
        background: const Color(0xFFFFF3EA),
        iconBackground: const Color(0xFFFBE2D1),
        onTap: () => onToolTap(TeacherTool.studentOrders),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Teaching tools',
          style: TextStyle(
            color: Color(0xFF192841),
            fontSize: 21,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final singleColumn = constraints.maxWidth < 330 ||
                MediaQuery.textScalerOf(context).scale(13) > 18;

            if (singleColumn) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int index = 0; index < tiles.length; index++) ...[
                    if (index > 0) const SizedBox(height: 10),
                    tiles[index],
                  ],
                ],
              );
            }

            return Column(
              children: [
                for (int index = 0; index < tiles.length; index += 2) ...[
                  if (index > 0) const SizedBox(height: 10),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: tiles[index]),
                        const SizedBox(width: 10),
                        Expanded(child: tiles[index + 1]),
                      ],
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTile({
    required String title,
    required IconData icon,
    required Color color,
    required Color background,
    required Color iconBackground,
    required VoidCallback onTap,
  }) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(17),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 80),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
            child: Row(
              children: [
                Container(
                  width: 39,
                  height: 43,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 25,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    softWrap: true,
                    style: const TextStyle(
                      color: Color(0xFF192841),
                      fontSize: 13,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 3),
                Icon(
                  Icons.chevron_right_rounded,
                  color: color.withAlpha(180),
                  size: 17,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}