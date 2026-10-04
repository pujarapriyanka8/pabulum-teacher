import 'package:flutter/material.dart';
import 'package:pabulum_teacher/model/my_students.dart';

class StudentDetailsDialog extends StatelessWidget {
  const StudentDetailsDialog({
    super.key,
    required this.student,
  });

  final MyStudent student;

  static Future<void> show(
      BuildContext context,
      MyStudent student,
      ) {
    FocusScope.of(context).unfocus();

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (_) => StudentDetailsDialog(student: student),
    );
  }

  String _display(Object? value) {
    final text = value?.toString().trim() ?? '';
    return text.isEmpty ? '—' : text;
  }

  @override
  Widget build(BuildContext context) {
    final name = _display(student.name);

    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header stays visible when the details scroll.
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 8, 0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Student details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202329),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFF555D70),
                    ),
                  ),
                ],
              ),
            ),

            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: ExcludeSemantics(
                        child: CircleAvatar(
                          radius: 36,
                          backgroundColor: const Color(0xFFE8E2FF),
                          child: name == '—'
                              ? const Icon(
                            Icons.person_outline_rounded,
                            size: 34,
                            color: Color(0xFF5746FF),
                          )
                              : Text(
                            name.characters.first.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF5746FF),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202329),
                      ),
                    ),
                    const SizedBox(height: 22),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0EDFF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final stackFields =
                              constraints.maxWidth < 220 ||
                                  MediaQuery.textScalerOf(context)
                                      .scale(14) >
                                      20;

                          final grField = _SummaryField(
                            label: 'GR number',
                            value: _display(student.grNumber),
                          );

                          final rollField = _SummaryField(
                            label: 'Roll number',
                            value: _display(student.rollNumber),
                          );

                          if (stackFields) {
                            return Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                grField,
                                const SizedBox(height: 16),
                                rollField,
                              ],
                            );
                          }

                          return Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Expanded(child: grField),
                              const SizedBox(width: 16),
                              Expanded(child: rollField),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),

                    _DetailRow(
                      icon: Icons.person_outline_rounded,
                      label: 'Username',
                      value: _display(student.username),
                    ),
                    const _DetailDivider(),
                    _DetailRow(
                      icon: Icons.mail_outline_rounded,
                      label: 'Email',
                      value: _display(student.email),
                    ),
                    const _DetailDivider(),
                    _DetailRow(
                      icon: Icons.phone_outlined,
                      label: 'Mobile',
                      value: _display(student.mobile),
                    ),
                    const _DetailDivider(),
                    _DetailRow(
                      icon: Icons.location_on_outlined,
                      label: 'Address',
                      value: _display(student.address),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryField extends StatelessWidget {
  const _SummaryField({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF737B90),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF202329),
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Icon(
              icon,
              size: 25,
              color: const Color(0xFF697185),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF737B90),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF202329),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailDivider extends StatelessWidget {
  const _DetailDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFEBEDF3),
    );
  }
}