import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pabulum_teacher/bloc/assignedclass/assigned_class_bloc.dart';
import 'package:pabulum_teacher/model/assigned_class_model.dart';


import 'package:pabulum_teacher/utils/utils.dart';

class AssignedClassesScreen extends StatelessWidget {
  const AssignedClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FD),
      appBar: Utils.customAppBar(
        'Assigned Classes',
        context,
        isBack: true,
        onBackPress: () => Navigator.of(context).pop(),
      ),
      body: BlocProvider(
        create: (_) => AssignedClassesBloc()
          ..add( AssignedClassesEvent.onLoadAssignedClasses()),
        child: BlocBuilder<AssignedClassesBloc, AssignedClassesState>(
          builder: (context, state) {
            final allGroups = _groupAssignments(
              state.arrAssignedClasses,
            );

            final query = state.query.trim().toLowerCase();

            final visibleGroups = <_ClassGroup>[];

            for (final group in allGroups) {
              if (query.isEmpty) {
                visibleGroups.add(group);
                continue;
              }

              final classMatches =
                  group.standard.toLowerCase().contains(query) ||
                      group.division.toLowerCase().contains(query) ||
                      '${group.standard} ${group.division}'
                          .toLowerCase()
                          .contains(query);

              final matchingSubjects = classMatches
                  ? group.subjects
                  : group.subjects
                  .where(
                    (item) => (item.subject?.name??'')
                    .toLowerCase()
                    .contains(query),
              )
                  .toList();

              if (matchingSubjects.isNotEmpty) {
                visibleGroups.add(
                  _ClassGroup(
                    key: group.key,
                    standard: group.standard,
                    division: group.division,
                    subjects: matchingSubjects,
                    palette: group.palette,
                  ),
                );
              }
            }

            final subjectCount = visibleGroups.fold<int>(
              0,
                  (total, group) => total + group.subjects.length,
            );

            return Stack(
              children: [
                SafeArea(
                  top: false,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16,
                              12,
                              16,
                              0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Your teaching assignments',
                                  style: TextStyle(
                                    color: Color(0xFF7C879B),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                TextField(
                                  controller: state.searchController,
                                  onChanged: (value) {
                                    context.read<AssignedClassesBloc>().add(
                                      AssignedClassesEvent
                                          .onSearchAssignedClasses(
                                        query: value,
                                      ),
                                    );
                                  },
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (_) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  style: const TextStyle(
                                    color: Color(0xFF142B49),
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:
                                    'Search class, division or subject',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF929CAE),
                                      fontSize: 13,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search_rounded,
                                      color: Color(0xFF64758D),
                                      size: 23,
                                    ),
                                    suffixIcon: state.query.isEmpty
                                        ? null
                                        : IconButton(
                                      tooltip: 'Clear search',
                                      onPressed: () {
                                        context
                                            .read<AssignedClassesBloc>()
                                            .add(
                                          const AssignedClassesEvent
                                              .onClearSearch(),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.close_rounded,
                                        color: Color(0xFF64758D),
                                        size: 21,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 14,
                                    ),
                                    enabledBorder: _searchBorder(),
                                    focusedBorder: _searchBorder(
                                      color: const Color(0xFF8D6BDF),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                if (!state.isLoading &&
                                    state.errorMessage == null)
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 8,
                                    children: [
                                      _SummaryChip(
                                        label:
                                        '${visibleGroups.length} '
                                            '${visibleGroups.length == 1 ? 'class' : 'classes'}',
                                        background:
                                        const Color(0xFFE9DFFF),
                                        foreground:
                                        const Color(0xFF6440A9),
                                      ),
                                      _SummaryChip(
                                        label:
                                        '$subjectCount '
                                            '${subjectCount == 1 ? 'subject assignment' : 'subject assignments'}',
                                        background:
                                        const Color(0xFFDDF3F1),
                                        foreground:
                                        const Color(0xFF177D79),
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                          Expanded(
                            child: state.isLoading &&
                                state.arrAssignedClasses.isEmpty
                                ? const SizedBox.shrink()
                                : visibleGroups.isEmpty
                                ? _EmptyState(
                              isSearching: query.isNotEmpty,
                              errorMessage: state.errorMessage,
                              onRetry: () {
                                context
                                    .read<AssignedClassesBloc>()
                                    .add(
                                  const AssignedClassesEvent
                                      .onLoadAssignedClasses(),
                                );
                              },
                            )
                                : ListView.builder(
                              keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior
                                  .onDrag,
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                0,
                                16,
                                20,
                              ),
                              itemCount: visibleGroups.length,
                              itemBuilder: (context, index) {
                                final group = visibleGroups[index];

                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 14,
                                  ),
                                  child: _AssignedClassCard(
                                    key: ValueKey(group.key),
                                    group: group,
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

  OutlineInputBorder _searchBorder({
    Color color = const Color(0xFFD5DEEB),
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AssignedClassCard extends StatelessWidget {
  const _AssignedClassCard({
    super.key,
    required this.group,
  });

  final _ClassGroup group;

  @override
  Widget build(BuildContext context) {
    final palette = group.palette;
    final number = _standardNumber(group.standard);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.background,
        borderRadius: BorderRadius.circular(18),
        border: Border(
          top: BorderSide(color: palette.accent, width: 4),
          left: BorderSide(color: palette.accent, width: 1),
          right: BorderSide(color: palette.accent, width: 1),
          bottom: BorderSide(color: palette.accent, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 3),
          LayoutBuilder(
            builder: (context, constraints) {
              final heading = Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: palette.badge,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: number == null
                        ? Icon(
                      Icons.school_outlined,
                      color: palette.foreground,
                      size: 24,
                    )
                        : Text(
                      number,
                      style: TextStyle(
                        color: palette.foreground,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _displayText(group.standard),
                      style: const TextStyle(
                        color: Color(0xFF142B49),
                        fontSize: 18,
                        height: 1.35,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              );

              final division = Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: palette.badge,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  'Division ${_displayText(group.division)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: palette.foreground,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );

              final stackHeader = constraints.maxWidth < 270 ||
                  MediaQuery.textScalerOf(context).scale(14) > 19;

              if (stackHeader) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heading,
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: division,
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: heading),
                  const SizedBox(width: 10),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth * 0.4,
                    ),
                    child: division,
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Divider(
              height: 1,
              color: palette.accent.withAlpha(55),
            ),
          ),
          const Text(
            'Assigned subjects',
            style: TextStyle(
              color: Color(0xFF748199),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 11),
          Wrap(
            spacing: 9,
            runSpacing: 9,
            children: [
              for (final item in group.subjects)
                _SubjectChip(
                  subject: item.subject?.name ?? '',
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubjectChip extends StatelessWidget {
  const _SubjectChip({required this.subject});

  final String subject;

  @override
  Widget build(BuildContext context) {
    final style = _subjectStyle(subject);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            style.icon,
            color: style.foreground,
            size: 21,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              _displayText(subject),
              softWrap: true,
              style: TextStyle(
                color: style.foreground,
                fontSize: 15,
                height: 1.35,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.isSearching,
    required this.errorMessage,
    required this.onRetry,
  });

  final bool isSearching;
  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              errorMessage != null
                  ? Icons.cloud_off_outlined
                  : isSearching
                  ? Icons.search_off_rounded
                  : Icons.school_outlined,
              color: const Color(0xFF8663C8),
              size: 36,
            ),
            const SizedBox(height: 14),
            Text(
              errorMessage ??
                  (isSearching
                      ? 'No matching classes'
                      : 'No classes assigned yet'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF142B49),
                fontSize: 15,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Presentation grouping only; the original API models stay unchanged.
class _ClassGroup {
  const _ClassGroup({
    required this.key,
    required this.standard,
    required this.division,
    required this.subjects,
    required this.palette,
  });

  final String key;
  final String standard;
  final String division;
  final List<AssignedClassData> subjects;
  final _ClassPalette palette;
}

List<_ClassGroup> _groupAssignments(
    List<AssignedClassData> assignments,
    ) {
  final grouped = <String, List<AssignedClassData>>{};

  for (final item in assignments) {
    final standardKey =
        (item.standardId ?? item.standard?.id)?.toString() ??
            'name:${item.standard?.name ?? ''}';

    final divisionKey =
        (item.divisionId ?? item.division?.id)?.toString() ??
            'name:${item.division?.name ?? ''}';

    final key = '${item.academicYearId ?? ''}'
        '\u0000$standardKey\u0000$divisionKey';

    grouped.putIfAbsent(key, () => []).add(item);
  }

  final result = <_ClassGroup>[];

  for (final entry in grouped.entries) {
    final first = entry.value.first;

    // Avoid duplicate chips for repeated copies of the same assignment.
    final uniqueSubjects = <String, AssignedClassData>{};

    for (final item in entry.value) {
      final subjectKey =
          (item.subjectId ?? item.subject?.id)?.toString() ??
              'name:${item.subject?.name ?? ''}';

      uniqueSubjects.putIfAbsent(subjectKey, () => item);
    }

    result.add(
      _ClassGroup(
        key: entry.key,
        standard: first.standard?.name ?? '',
        division: first.division?.name ?? '',
        subjects: uniqueSubjects.values.toList(),
        palette: _classPalettes[result.length % _classPalettes.length],
      ),
    );
  }

  return result;
}

class _ClassPalette {
  const _ClassPalette({
    required this.background,
    required this.accent,
    required this.badge,
    required this.foreground,
  });

  final Color background;
  final Color accent;
  final Color badge;
  final Color foreground;
}

const _classPalettes = [
  _ClassPalette(
    background: Color(0xFFF6F1FF),
    accent: Color(0xFFA787F3),
    badge: Color(0xFFE3D7FC),
    foreground: Color(0xFF573295),
  ),
  _ClassPalette(
    background: Color(0xFFF0F7FF),
    accent: Color(0xFF6EA4F1),
    badge: Color(0xFFD9E7FF),
    foreground: Color(0xFF24589C),
  ),
  _ClassPalette(
    background: Color(0xFFEDF9F4),
    accent: Color(0xFF63BDA0),
    badge: Color(0xFFCEF0E3),
    foreground: Color(0xFF247B60),
  ),
];

class _SubjectStyle {
  const _SubjectStyle({
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final Color background;
  final Color foreground;
}

_SubjectStyle _subjectStyle(String subject) {
  final value = subject.trim().toLowerCase();

  if (value.contains('ગણિત') || value.contains('math')) {
    return const _SubjectStyle(
      icon: Icons.calculate_outlined,
      background: Color(0xFFDDE7FF),
      foreground: Color(0xFF24579C),
    );
  }

  if (value.contains('વિજ્ઞાન') ||
      value.contains('વિગ્નાન') ||
      value.contains('science')) {
    return const _SubjectStyle(
      icon: Icons.science_outlined,
      background: Color(0xFFFFECDD),
      foreground: Color(0xFF945C32),
    );
  }

  if (value.contains('english') || value.contains('અંગ્રેજી')) {
    return const _SubjectStyle(
      icon: Icons.menu_book_rounded,
      background: Color(0xFFECE0FC),
      foreground: Color(0xFF7444AA),
    );
  }

  return const _SubjectStyle(
    icon: Icons.menu_book_rounded,
    background: Color(0xFFDFF4E8),
    foreground: Color(0xFF177B68),
  );
}

String? _standardNumber(String standard) {
  const gujaratiDigits = '૦૧૨૩૪૫૬૭૮૯';
  var normalized = standard;

  for (var index = 0; index < gujaratiDigits.length; index++) {
    normalized = normalized.replaceAll(
      gujaratiDigits[index],
      index.toString(),
    );
  }

  final match = RegExp(r'\d+').firstMatch(normalized);
  if (match == null) return null;

  final number = int.tryParse(match.group(0)!);
  return number?.toString().padLeft(2, '0');
}

String _displayText(String value) {
  final text = value.trim();
  return text.isEmpty ? '—' : text;
}