
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pabulum_teacher/bloc/assignedclass/assigned_class_bloc.dart';
import 'package:pabulum_teacher/model/assigned_class_model.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class AssignedClassesScreen extends StatelessWidget {
  const AssignedClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (_) => AssignedClassesBloc()
          ..add(
            AssignedClassesEvent.onLoadAssignedClasses(),
          ),
        child: BlocBuilder<
            AssignedClassesBloc,
            AssignedClassesState>(
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
                    (item) => (item.subject?.name ?? '')
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
                  ),
                );
              }
            }

            final subjectCount = visibleGroups.fold<int>(
              0,
                  (total, group) =>
              total + group.subjects.length,
            );

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
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: CustomAppBar(
                              title: 'Assigned Classes',
                              subtitle:
                              'View your teaching assignments\nacross classes and subjects.',
                              image: AppImages.icAssignedClass,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16,
                              0,
                              16,
                              0,
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller:
                                  state.searchController,
                                  onChanged: (value) {
                                    context
                                        .read<AssignedClassesBloc>()
                                        .add(
                                      AssignedClassesEvent
                                          .onSearchAssignedClasses(
                                        query: value,
                                      ),
                                    );
                                  },
                                  textInputAction:
                                  TextInputAction.search,
                                  onSubmitted: (_) {
                                    FocusScope.of(context)
                                        .unfocus();
                                  },
                                  style: TextStyle(
                                    color: AppColors.ink,
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    hintText:
                                    'Search class, division or subject',
                                    hintStyle: TextStyle(
                                      color: AppColors.muted,
                                      fontSize: 13,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search_rounded,
                                      color: AppColors.purple,
                                      size: 25,
                                    ),
                                    suffixIcon: state.query.isEmpty
                                        ? null
                                        : IconButton(
                                      tooltip: 'Clear search',
                                      onPressed: () {
                                        context
                                            .read<
                                            AssignedClassesBloc>()
                                            .add(
                                          const AssignedClassesEvent
                                              .onClearSearch(),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: AppColors.muted,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: AppColors.surface,
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 16,
                                    ),
                                    border: _searchBorder(),
                                    enabledBorder: _searchBorder(),
                                    focusedBorder: _searchBorder(
                                      color: AppColors.purple,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                if (!state.isLoading &&
                                    state.errorMessage == null)
                                  Wrap(
                                    spacing: 9,
                                    runSpacing: 8,
                                    children: [
                                      _buildSummaryChip(
                                        label:
                                        '${visibleGroups.length} '
                                            '${visibleGroups.length == 1 ? 'class' : 'classes'}',
                                        background:
                                        const Color(0xFFEDE3FF),
                                        foreground:
                                        const Color(0xFF7047C6),
                                        icon: Icons.school_rounded,
                                      ),
                                      _buildSummaryChip(
                                        label:
                                        '$subjectCount '
                                            '${subjectCount == 1 ? 'subject assignment' : 'subject assignments'}',
                                        background:
                                        const Color(0xFFDDF6EC),
                                        foreground:
                                        const Color(0xFF279B7B),
                                        icon:
                                        Icons.menu_book_rounded,
                                      ),
                                    ],
                                  ),
                                const SizedBox(height: 14),
                              ],
                            ),
                          ),
                          Expanded(
                            child: state.isLoading &&
                                state.arrAssignedClasses.isEmpty
                                ? const SizedBox.shrink()
                                : visibleGroups.isEmpty
                                ? _buildEmptyState(
                              isSearching:
                              query.isNotEmpty,
                              errorMessage:
                              state.errorMessage,
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
                              padding:
                              const EdgeInsets.fromLTRB(
                                16,
                                0,
                                16,
                                16,
                              ),
                              itemCount:
                              visibleGroups.length,
                              itemBuilder:
                                  (context, index) {
                                final group =
                                visibleGroups[index];

                                return Padding(
                                  padding:
                                  const EdgeInsets.only(
                                    bottom: 12,
                                  ),
                                  child:
                                  _buildAssignedClassCard(
                                    group: group,
                                    index: index,
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
    Color? color,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(
        color: color ?? AppColors.colorGrey1,
      ),
    );
  }

  Widget _buildSummaryChip({
    required String label,
    required Color background,
    required Color foreground,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: foreground.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: foreground,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: foreground,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignedClassCard({
    required _ClassGroup group,
    required int index,
  }) {
    final accentColor = Utils.getCardBorderColor(index);
    final number = _standardNumber(group.standard);

    return Container(
      key: ValueKey(group.key),
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: Utils.cardDecoration(
        index: index,
        radius: 18,
        topWidth: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 3),
          LayoutBuilder(
            builder: (context, constraints) {
              final heading = Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(
                        alpha: 0.13,
                      ),
                      borderRadius:
                      BorderRadius.circular(13),
                    ),
                    child: number == null
                        ? Icon(
                      Icons.school_rounded,
                      color: accentColor,
                      size: 25,
                    )
                        : Text(
                      number,
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Text(
                      _displayText(group.standard),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.ink,
                        fontSize: 17,
                        height: 1.25,
                        fontWeight: FontWeight.w800,
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
                  color: accentColor.withValues(
                    alpha: 0.13,
                  ),
                  borderRadius:
                  BorderRadius.circular(11),
                ),
                child: Text(
                  'Division ${_displayText(group.division)}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );

              final stackHeader =
                  constraints.maxWidth < 270 ||
                      MediaQuery.textScalerOf(context)
                          .scale(14) >
                          19;

              if (stackHeader) {
                return Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
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
                  const SizedBox(width: 8),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth:
                      constraints.maxWidth * 0.4,
                    ),
                    child: division,
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Divider(
              height: 1,
              color: accentColor.withValues(alpha: 0.20),
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.auto_stories_rounded,
                color: accentColor,
                size: 17,
              ),
              const SizedBox(width: 7),
              Text(
                'Assigned subjects',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in group.subjects)
                _buildSubjectChip(
                  item.subject?.name ?? '',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectChip(String subject) {
    final style = _subjectStyle(subject);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: style.background,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: style.foreground.withValues(
            alpha: 0.12,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            style.icon,
            color: style.foreground,
            size: 19,
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              _displayText(subject),
              softWrap: true,
              style: TextStyle(
                color: style.foreground,
                fontSize: 13,
                height: 1.3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required bool isSearching,
    required String? errorMessage,
    required VoidCallback onRetry,
  }) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFFEDE3FF),
                borderRadius:
                BorderRadius.circular(22),
              ),
              child: Icon(
                errorMessage != null
                    ? Icons.cloud_off_outlined
                    : isSearching
                    ? Icons.search_off_rounded
                    : Icons.school_outlined,
                color: AppColors.purple,
                size: 34,
              ),
            ),
            const SizedBox(height: 13),
            Text(
              errorMessage ??
                  (isSearching
                      ? 'No matching classes'
                      : 'No classes assigned yet'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 15,
                height: 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(
                  Icons.refresh_rounded,
                ),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<_ClassGroup> _groupAssignments(
      List<AssignedClassData> assignments,
      ) {
    final grouped =
    <String, List<AssignedClassData>>{};

    for (final item in assignments) {
      final standardKey =
          (item.standardId ?? item.standard?.id)
              ?.toString() ??
              'name:${item.standard?.name ?? ''}';

      final divisionKey =
          (item.divisionId ?? item.division?.id)
              ?.toString() ??
              'name:${item.division?.name ?? ''}';

      final key = '${item.academicYearId ?? ''}'
          '\u0000$standardKey\u0000$divisionKey';

      grouped.putIfAbsent(key, () => []).add(item);
    }

    final result = <_ClassGroup>[];

    for (final entry in grouped.entries) {
      final first = entry.value.first;

      final uniqueSubjects =
      <String, AssignedClassData>{};

      for (final item in entry.value) {
        final subjectKey =
            (item.subjectId ?? item.subject?.id)
                ?.toString() ??
                'name:${item.subject?.name ?? ''}';

        uniqueSubjects.putIfAbsent(
          subjectKey,
              () => item,
        );
      }

      result.add(
        _ClassGroup(
          key: entry.key,
          standard: first.standard?.name ?? '',
          division: first.division?.name ?? '',
          subjects: uniqueSubjects.values.toList(),
        ),
      );
    }

    return result;
  }

  _SubjectStyle _subjectStyle(String subject) {
    final value = subject.trim().toLowerCase();

    if (value.contains('ગણિત') ||
        value.contains('math')) {
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

    if (value.contains('english') ||
        value.contains('અંગ્રેજી')) {
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

    for (var index = 0;
    index < gujaratiDigits.length;
    index++) {
      normalized = normalized.replaceAll(
        gujaratiDigits[index],
        index.toString(),
      );
    }

    final match =
    RegExp(r'\d+').firstMatch(normalized);

    if (match == null) return null;

    final number =
    int.tryParse(match.group(0)!);

    return number?.toString().padLeft(2, '0');
  }

  String _displayText(String value) {
    final text = value.trim();
    return text.isEmpty ? '—' : text;
  }
}

class _ClassGroup {
  const _ClassGroup({
    required this.key,
    required this.standard,
    required this.division,
    required this.subjects,
  });

  final String key;
  final String standard;
  final String division;
  final List<AssignedClassData> subjects;
}

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
