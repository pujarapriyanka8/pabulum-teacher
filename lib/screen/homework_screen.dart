import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/homework/homework_bloc.dart';
import 'package:pabulum_teacher/model/homework_model.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: Utils.customAppBar(
        'Homework',
        context,
        isBack: true,
        onBackPress: () => Navigator.of(context).pop(),
      ),
      body: BlocProvider(
        create: (_) => HomeworkBloc()
          ..add(const HomeworkEvent.onLoadHomeworkData()),
        child: BlocBuilder<HomeworkBloc, HomeworkState>(
          builder: (context, state) {
            final homeworkList = state.arrHomeWork;

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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16,
                              14,
                              16,
                              0,
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: state.searchController,
                                  onChanged: (value) {
                                    context.read<HomeworkBloc>().add(
                                      HomeworkEvent.onLoadHomeworkData(
                                        search: value,
                                      ),
                                    );
                                  },
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (_) {
                                    FocusScope.of(context).unfocus();
                                  },
                                  style: const TextStyle(
                                    color: Color(0xFF19243B),
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Search homework title',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF929BAD),
                                      fontSize: 14,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search_rounded,
                                      color: Color(0xFF69758D),
                                      size: 22,
                                    ),
                                    suffixIcon: state.search.isEmpty
                                        ? null
                                        : IconButton(
                                      tooltip: 'Clear search',
                                      onPressed: () {
                                        state.searchController.clear();

                                        context
                                            .read<HomeworkBloc>()
                                            .add(
                                          const HomeworkEvent
                                              .onLoadHomeworkData(),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.close_rounded,
                                        color: Color(0xFF69758D),
                                        size: 21,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 13,
                                    ),
                                    enabledBorder: _searchBorder(),
                                    focusedBorder: _searchBorder(
                                      color: const Color(0xFF7950E8),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),

                                // Heading and Add Homework button.
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.search.trim().isEmpty
                                            ? 'All homework'
                                            : 'Search results',
                                        style: const TextStyle(
                                          color: Color(0xFF19243B),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    FilledButton.icon(
                                      onPressed: state.isLoading
                                          ? null
                                          : () async {
                                        // Add Homework
                                        final saved = await Navigator.of(context).pushNamed(
                                          RouteName.addHomeworkScreen,
                                          arguments: true,
                                        );

                                        if (!context.mounted || saved != true) return;

                                        final bloc = context.read<HomeworkBloc>();

                                        bloc.add(
                                          HomeworkEvent.onLoadHomeworkData(
                                            search: bloc.state.search,
                                          ),
                                        );
                                      },
                                      style: FilledButton.styleFrom(
                                        backgroundColor: const Color(0xFF168B80),
                                        foregroundColor: Colors.white,
                                        minimumSize: const Size(48, 48),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 10,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.add_rounded,
                                        size: 20,
                                      ),
                                      label: const Text(
                                        'Add Homework',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),

                          Expanded(
                            child: homeworkList.isEmpty
                                ? state.isLoading
                                ? const SizedBox.shrink()
                                : _HomeworkEmptyState(
                              isSearching:
                              state.search.trim().isNotEmpty,
                            )
                                : ListView.builder(
                              keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior
                                  .onDrag,
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                0,
                                16,
                                8,
                              ),
                              itemCount: homeworkList.length,
                              itemBuilder: (context, index) {
                                final homework = homeworkList[index];

                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 12,
                                  ),
                                  child: _HomeworkCard(
                                    key: ValueKey(homework.id),
                                    homework: homework,
                                    onView: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteName.homeworkDetailScreen,
                                        arguments: homework.id,
                                      );
                                    },
                                    onDelete: () {
                                      _confirmDelete(context, homework);
                                    },
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
    Color color = const Color(0xFFE1E5EF),
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context,
      HomeWorkData homework,
      ) async {
    final bloc = context.read<HomeworkBloc>();

    showDeleteHomeworkDialog(
      context,
      title: homework.title??'',
      classDetails: '${_displayText(homework.standard?.name)}'
          ' • ${_displayText(homework.division?.name)}',
      startDate: homework.startDate ?? '',
      dueDate: homework.dueDate ?? '',
      onDelete: () {
        bloc.add(
          HomeworkEvent.onDeleteHomework(homeworkId: homework.id.toString()),
        );
      },
    );
    }
  }


Future<void> showDeleteHomeworkDialog(
    BuildContext context, {
      required String title,
      required String classDetails,
      required String startDate,
      required String dueDate,
      required VoidCallback onDelete,
    }) async {
  const navy = Color(0xFF19233E);
  const muted = Color(0xFF78839F);
  const red = Color(0xFFEF6070);
  const border = Color(0xFFE9E4F5);

  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: const Color(0x800F172A),
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEDF0),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      color: red,
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'DELETE HOMEWORK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: red,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Are you sure?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: navy,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'You are about to delete this homework. '
                      'This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: muted,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 22),

                // Homework details
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF9FF),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1ECFF),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.edit_note_rounded,
                          color: Color(0xFF8A72CF),
                          size: 27,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'HOMEWORK',
                              style: TextStyle(
                                color: Color(0xFF969DB1),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              title,
                              style: const TextStyle(
                                color: navy,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              classDetails,
                              style: const TextStyle(
                                color: muted,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Dates
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: border),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'START DATE',
                              style: TextStyle(
                                color: Color(0xFF969DB1),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              startDate,
                              style: const TextStyle(
                                color: navy,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Color(0xFFC2BAD9),
                          size: 21,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'DUE DATE',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFF969DB1),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              dueDate,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: red,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Warning
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8EC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFE8A12D),
                        size: 21,
                      ),
                      SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          'Once deleted, this homework cannot be recovered.',
                          style: TextStyle(
                            color: Color(0xFFAC741C),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),

                // Action buttons
                LayoutBuilder(
                  builder: (context, constraints) {
                    final cancelButton = OutlinedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: muted,
                        minimumSize: const Size(0, 48),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        side: const BorderSide(
                          color: Color(0xFFDDD6ED),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );

                    final deleteButton = ElevatedButton(
                      onPressed: () {
                        // Close this dialog, then dispatch the delete event.
                        Navigator.of(dialogContext).pop();
                        onDelete();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(0, 48),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_outline_rounded,
                            size: 18,
                          ),
                          SizedBox(width: 7),
                          Flexible(
                            child: Text(
                              'Delete Homework',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    final stackButtons = constraints.maxWidth < 300 ||
                        MediaQuery.textScalerOf(context).scale(13) > 18;

                    if (stackButtons) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          deleteButton,
                          const SizedBox(height: 10),
                          cancelButton,
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: cancelButton,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 6,
                          child: deleteButton,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
class _HomeworkCard extends StatelessWidget {
  const _HomeworkCard({
    super.key,
    required this.homework,
    required this.onView,
    required this.onDelete,
  });

  final HomeWorkData homework;
  final VoidCallback onView;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final palette = _paletteFor(homework);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: palette.background.withAlpha(128),
        borderRadius: BorderRadius.circular(18),
        border: Border(
          top: BorderSide(
            color: palette.accent,
            width: 6,
          ),
          left: BorderSide(
            color: palette.accent,
            width: 1,
          ),
          right: BorderSide(
            color: palette.accent,
            width: 1,
          ),
          bottom: BorderSide(
            color: palette.accent,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          5.height,
          _HomeworkSubjectHeader(
            homework: homework,
            palette: palette,
          ),
          const SizedBox(height: 6),
          _HomeworkTitleActions(
            title: _displayText(homework.title),
            onView: onView,
            onDelete: onDelete,
          ),
          const SizedBox(height: 10),
          _LessonTopicRow(
            lesson: homework.lesson?.name ?? '',
            topic: homework.topic?.name ?? '',
            accent: palette.accent,
          ),
          const SizedBox(height: 14),
          _HomeworkDates(
            startDate: homework.startDate ?? '',
            dueDate: homework.dueDate ?? '',
          ),
        ],
      ),
    );
  }
}

class _HomeworkSubjectHeader extends StatelessWidget {
  const _HomeworkSubjectHeader({
    required this.homework,
    required this.palette,
  });

  final HomeWorkData homework;
  final _HomeworkPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            palette.header,
            palette.header.withAlpha(120),
          ],
        ),
        borderRadius: BorderRadius.circular(13),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: palette.iconBackground,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  Icons.menu_book_rounded,
                  color: palette.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  _displayText(homework.subject?.name),
                  style: const TextStyle(
                    color: Color(0xFF19243B),
                    fontSize: 14,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Kept at the right edge of the row.
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth * 0.44,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: palette.iconBackground,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    '${_displayText(homework.standard?.name)}'
                        ' • ${_displayText(homework.division?.name)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: palette.accent,
                      fontSize: 11,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HomeworkTitleActions extends StatelessWidget {
  const _HomeworkTitleActions({
    required this.title,
    required this.onView,
    required this.onDelete,
  });

  final String title;
  final VoidCallback onView;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final largeText =
            MediaQuery.textScalerOf(context).scale(13) > 18;

        final stackActions = constraints.maxWidth < 290 || largeText;

        final titleWidget = Text(
          title,
          softWrap: true,
          style: const TextStyle(
            color: Color(0xFF19243B),
            fontSize: 16,
            height: 1.35,
            fontWeight: FontWeight.w700,
          ),
        );

        final actions = Wrap(
          spacing: 2,
          runSpacing: 2,
          children: [
            _HomeworkAction(
              label: 'View',
              icon: Icons.visibility_outlined,
              color: const Color(0xFF177C9B),
              onTap: onView,
            ),
            _HomeworkAction(
              label: 'Delete',
              icon: Icons.delete_outline_rounded,
              color: const Color(0xFFC74B67),
              onTap: onDelete,
            ),
          ],
        );

        if (stackActions) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              titleWidget,
              Align(
                alignment: Alignment.centerRight,
                child: actions,
              ),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: titleWidget),
            const SizedBox(width: 6),
            actions,
          ],
        );
      },
    );
  }
}

class _HomeworkAction extends StatelessWidget {
  const _HomeworkAction({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: color,
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonTopicRow extends StatelessWidget {
  const _LessonTopicRow({
    required this.lesson,
    required this.topic,
    required this.accent,
  });

  final String lesson;
  final String topic;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _HomeworkField(
            label: 'Lesson',
            value: lesson,
            icon: Icons.menu_book_outlined,
            accent: accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _HomeworkField(
            label: 'Topic',
            value: topic,
            icon: Icons.lightbulb_outline_rounded,
            accent: accent,
          ),
        ),
      ],
    );
  }
}

class _HomeworkField extends StatelessWidget {
  const _HomeworkField({
    required this.label,
    required this.value,
    required this.icon,
    required this.accent,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 17,
              color: accent,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF748097),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          _displayText(value),
          softWrap: true,
          style: const TextStyle(
            color: Color(0xFF29354D),
            fontSize: 13,
            height: 1.45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _HomeworkDates extends StatelessWidget {
  const _HomeworkDates({
    required this.startDate,
    required this.dueDate,
  });

  final String startDate;
  final String dueDate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stackDates = constraints.maxWidth < 260 ||
            MediaQuery.textScalerOf(context).scale(13) > 18;

        final start = _HomeworkDateBox(
          label: 'Start date',
          value: startDate,
          icon: Icons.calendar_today_outlined,
          background: const Color(0xFFE2EFFF),
          foreground: const Color(0xFF327CA5),
        );

        final due = _HomeworkDateBox(
          label: 'Due date',
          value: dueDate,
          icon: Icons.event_outlined,
          background: const Color(0xFFFFEBDD),
          foreground: const Color(0xFFB87642),
        );

        if (stackDates) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              start,
              const SizedBox(height: 8),
              due,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: start),
            const SizedBox(width: 8),
            Expanded(child: due),
          ],
        );
      },
    );
  }
}

class _HomeworkDateBox extends StatelessWidget {
  const _HomeworkDateBox({
    required this.label,
    required this.value,
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 19,
            color: foreground,
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF647189),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _displayText(value),
                  softWrap: true,
                  style: const TextStyle(
                    color: Color(0xFF24314A),
                    fontSize: 12,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
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

class _HomeworkEmptyState extends StatelessWidget {
  const _HomeworkEmptyState({
    required this.isSearching,
  });

  final bool isSearching;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEEE7FC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                isSearching
                    ? Icons.search_off_rounded
                    : Icons.menu_book_rounded,
                color: const Color(0xFF7950E8),
                size: 32,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              isSearching
                  ? 'No matching homework'
                  : 'No homework available',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF19243B),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isSearching
                  ? 'Try searching for another title.'
                  : 'Tap Add Homework to get started.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF748097),
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeworkPalette {
  const _HomeworkPalette({
    required this.background,
    required this.header,
    required this.iconBackground,
    required this.accent,
  });

  final Color background;
  final Color header;
  final Color iconBackground;
  final Color accent;
}

const _homeworkPalettes = [
  _HomeworkPalette(
    background: Color(0xFFF5F0FF),
    header: Color(0xFFEDE3FF),
    iconBackground: Color(0xFFDFCEFC),
    accent: Color(0xFF8A62D6),
  ),
  _HomeworkPalette(
    background: Color(0xFFEDF9F4),
    header: Color(0xFFDDF6EC),
    iconBackground: Color(0xFFBFEBDD),
    accent: Color(0xFF279B7B),
  ),
  _HomeworkPalette(
    background: Color(0xFFEEF5FF),
    header: Color(0xFFE0EDFF),
    iconBackground: Color(0xFFCADDFA),
    accent: Color(0xFF4A90D6),
  ),
];

_HomeworkPalette _paletteFor(HomeWorkData homework) {
  final key = homework.id?.toString() ?? homework.title ?? '';

  final index = key.codeUnits.fold<int>(
    0,
        (sum, value) => sum + value,
  ) %
      _homeworkPalettes.length;

  return _homeworkPalettes[index];
}

String _displayText(String? value) {
  final text = value?.trim() ?? '';
  return text.isEmpty ? '—' : text;
}