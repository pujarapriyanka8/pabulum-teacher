
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pabulum_teacher/bloc/homework/homework_bloc.dart';
import 'package:pabulum_teacher/model/homework_model.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (_) => HomeworkBloc()
          ..add(const HomeworkEvent.onLoadHomeworkData()),
        child: BlocBuilder<HomeworkBloc, HomeworkState>(
          builder: (context, state) {
            final homeworkList = state.arrHomeWork;

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
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: CustomAppBar(
                              title: 'Homework',
                              subtitle: 'Manage and share homework\nwith your students.',
                              image: AppImages.icHomeworkHeader,
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(
                              16,
                              0,
                              16,
                              0,
                            ),
                            child: Column(
                              children: [
                                _buildSearchField(
                                  context,
                                  state,
                                ),
                                const SizedBox(height: 17),
                                _buildTitleRow(
                                  context,
                                  state,
                                ),
                                const SizedBox(height: 13),
                              ],
                            ),
                          ),
                          Expanded(
                            child: homeworkList.isEmpty
                                ? state.isLoading
                                ? const SizedBox.shrink()
                                : _buildEmptyState(
                              isSearching: state.search
                                  .trim()
                                  .isNotEmpty,
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
                              homeworkList.length,
                              itemBuilder:
                                  (context, index) {
                                final homework =
                                homeworkList[index];

                                return Padding(
                                  key: ValueKey(
                                    homework.id,
                                  ),
                                  padding:
                                  const EdgeInsets.only(
                                    bottom: 12,
                                  ),
                                  child:
                                  _buildHomeworkCard(
                                    homework: homework,
                                    index: index,
                                    onView: () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteName
                                            .homeworkDetailScreen,
                                        arguments:
                                        homework.id,
                                      );
                                    },
                                    onDelete: () {
                                      _confirmDelete(
                                        context,
                                        homework,
                                      );
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

  Widget _buildSearchField(
      BuildContext context,
      HomeworkState state,
      ) {
    return TextField(
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
      style: TextStyle(
        color: AppColors.ink,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: 'Search homework title...',
        hintStyle: TextStyle(
          color: AppColors.muted,
          fontSize: 13,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: AppColors.purple,
          size: 24,
        ),
        suffixIcon: state.search.isEmpty
            ? null
            : IconButton(
          tooltip: 'Clear search',
          onPressed: () {
            state.searchController.clear();

            context.read<HomeworkBloc>().add(
              const HomeworkEvent
                  .onLoadHomeworkData(),
            );
          },
          icon: Icon(
            Icons.close_rounded,
            color: AppColors.muted,
            size: 21,
          ),
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
        border: _searchBorder(),
        enabledBorder: _searchBorder(),
        focusedBorder: _searchBorder(
          color: AppColors.purple,
        ),
      ),
    );
  }

  OutlineInputBorder _searchBorder({
    Color? color,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(17),
      borderSide: BorderSide(
        color: color ?? AppColors.colorGrey1,
      ),
    );
  }

  Widget _buildTitleRow(
      BuildContext context,
      HomeworkState state,
      ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            state.search.trim().isEmpty
                ? 'All homework'
                : 'Search results',
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 8),
        FilledButton.icon(
          onPressed: state.isLoading
              ? null
              : () async {
            final saved =
            await Navigator.of(context).pushNamed(
              RouteName.addHomeworkScreen,
              arguments: true,
            );

            if (!context.mounted ||
                saved != true) {
              return;
            }

            final bloc =
            context.read<HomeworkBloc>();

            bloc.add(
              HomeworkEvent.onLoadHomeworkData(
                search: bloc.state.search,
              ),
            );
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.purple,
            foregroundColor: AppColors.white,
            minimumSize: const Size(48, 44),
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          icon: const Icon(
            Icons.add_rounded,
            size: 19,
          ),
          label: const Text(
            'Add Homework',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHomeworkCard({
    required HomeWorkData homework,
    required int index,
    required VoidCallback onView,
    required VoidCallback onDelete,
  }) {
    final accentColor =
    Utils.getCardBorderColor(index);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: Utils.cardDecoration(
        index: index,
        radius: 18,
        topWidth: 6,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: [
          _buildSubjectHeader(
            homework: homework,
            accentColor: accentColor,
          ),
          const SizedBox(height: 8),
          _buildTitleActions(
            title: _displayText(homework.title),
            onView: onView,
            onDelete: onDelete,
          ),
          const SizedBox(height: 12),
          _buildLessonTopicRow(
            lesson: homework.lesson?.name ?? '',
            topic: homework.topic?.name ?? '',
            accentColor: accentColor,
          ),
          const SizedBox(height: 14),
          _buildDates(
            startDate: homework.startDate ?? '',
            dueDate: homework.dueDate ?? '',
          ),
        ],
      ),
    );
  }


  Widget _buildSubjectHeader({
    required HomeWorkData homework,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.menu_book_rounded,
              size: 21,
              color: accentColor,
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              _displayText(homework.subject?.name),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 7),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 125,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_displayText(homework.standard?.name)}'
                    ' • ${_displayText(homework.division?.name)}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildTitleActions({
    required String title,
    required VoidCallback onView,
    required VoidCallback onDelete,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final titleWidget = Text(
          title,
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            height: 1.3,
          ),
        );

        final actions = Wrap(
          spacing: 2,
          runSpacing: 2,
          children: [
            _buildAction(
              label: 'View',
              icon: Icons.visibility_outlined,
              color: const Color(0xFF1689BF),
              onTap: onView,
            ),
            _buildAction(
              label: 'Delete',
              icon: Icons.delete_outline_rounded,
              color: const Color(0xFFE84C73),
              onTap: onDelete,
            ),
          ],
        );

        final stackActions =
            constraints.maxWidth < 290 ||
                MediaQuery.textScalerOf(context)
                    .scale(13) >
                    18;

        if (stackActions) {
          return Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              titleWidget,
              Align(
                alignment: Alignment.centerRight,
                child: actions,
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: titleWidget),
            const SizedBox(width: 4),
            actions,
          ],
        );
      },
    );
  }

  Widget _buildAction({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: color,
        minimumSize: const Size(48, 42),
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 17,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonTopicRow({
    required String lesson,
    required String topic,
    required Color accentColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildInfoField(
            label: 'Lesson',
            value: lesson,
            icon: Icons.menu_book_outlined,
            accentColor: accentColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildInfoField(
            label: 'Topic',
            value: topic,
            icon: Icons.lightbulb_outline_rounded,
            accentColor: accentColor,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoField({
    required String label,
    required String value,
    required IconData icon,
    required Color accentColor,
  }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: accentColor,
              size: 17,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          _displayText(value),
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 13,
            height: 1.35,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDates({
    required String startDate,
    required String dueDate,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final start = _buildDateBox(
          label: 'Start date',
          value: startDate,
          icon: Icons.calendar_today_outlined,
          background: const Color(0xFFE2F1FF),
          foreground: const Color(0xFF2088C0),
        );

        final due = _buildDateBox(
          label: 'Due date',
          value: dueDate,
          icon: Icons.event_outlined,
          background: const Color(0xFFFFECDD),
          foreground: const Color(0xFFC8732A),
        );

        final stackDates =
            constraints.maxWidth < 260 ||
                MediaQuery.textScalerOf(context)
                    .scale(13) >
                    18;

        if (stackDates) {
          return Column(
            children: [
              start,
              const SizedBox(height: 8),
              due,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: start),
            const SizedBox(width: 8),
            Expanded(child: due),
          ],
        );
      },
    );
  }

  Widget _buildDateBox({
    required String label,
    required String value,
    required IconData icon,
    required Color background,
    required Color foreground,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: foreground,
            size: 21,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _displayText(value),
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required bool isSearching,
  }) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE3FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                isSearching
                    ? Icons.search_off_rounded
                    : Icons.menu_book_rounded,
                color: AppColors.purple,
                size: 32,
              ),
            ),
            const SizedBox(height: 13),
            Text(
              isSearching
                  ? 'No matching homework'
                  : 'No homework available',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isSearching
                  ? 'Try searching for another title.'
                  : 'Tap Add Homework to get started.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context,
      HomeWorkData homework,
      ) async {
    final bloc = context.read<HomeworkBloc>();

    await showDeleteHomeworkDialog(
      context,
      title: homework.title ?? '',
      classDetails:
      '${_displayText(homework.standard?.name)}'
          ' • ${_displayText(homework.division?.name)}',
      startDate: homework.startDate ?? '',
      dueDate: homework.dueDate ?? '',
      onDelete: () {
        bloc.add(
          HomeworkEvent.onDeleteHomework(
            homeworkId: homework.id.toString(),
          ),
        );
      },
    );
  }

  String _displayText(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? '—' : text;
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
          constraints:
          const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEDF0),
                      borderRadius:
                      BorderRadius.circular(22),
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
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF9FF),
                    borderRadius:
                    BorderRadius.circular(14),
                    border: Border.all(
                      color: border,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFF1ECFF),
                          borderRadius:
                          BorderRadius.circular(13),
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
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'HOMEWORK',
                              style: TextStyle(
                                color:
                                Color(0xFF969DB1),
                                fontSize: 11,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              title,
                              style: const TextStyle(
                                color: navy,
                                fontSize: 15,
                                fontWeight:
                                FontWeight.w800,
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
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(14),
                    border: Border.all(
                      color: border,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'START DATE',
                              style: TextStyle(
                                color:
                                Color(0xFF969DB1),
                                fontSize: 11,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              startDate,
                              style: const TextStyle(
                                color: navy,
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                        EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Color(0xFFC2BAD9),
                          size: 21,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'DUE DATE',
                              textAlign:
                              TextAlign.right,
                              style: TextStyle(
                                color:
                                Color(0xFF969DB1),
                                fontSize: 11,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              dueDate,
                              textAlign:
                              TextAlign.right,
                              style: const TextStyle(
                                color: red,
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8EC),
                    borderRadius:
                    BorderRadius.circular(12),
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
                          'Once deleted, this homework '
                              'cannot be recovered.',
                          style: TextStyle(
                            color: Color(0xFFAC741C),
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final cancelButton =
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(dialogContext)
                            .pop();
                      },
                      style:
                      OutlinedButton.styleFrom(
                        foregroundColor: muted,
                        minimumSize:
                        const Size(0, 48),
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        side: const BorderSide(
                          color:
                          Color(0xFFDDD6ED),
                        ),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                          FontWeight.w700,
                        ),
                      ),
                    );

                    final deleteButton =
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(dialogContext)
                            .pop();
                        onDelete();
                      },
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor: red,
                        foregroundColor:
                        Colors.white,
                        elevation: 0,
                        minimumSize:
                        const Size(0, 48),
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_outline_rounded,
                            size: 18,
                          ),
                          SizedBox(width: 7),
                          Flexible(
                            child: Text(
                              'Delete Homework',
                              textAlign:
                              TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    final stackButtons =
                        constraints.maxWidth < 300 ||
                            MediaQuery.textScalerOf(
                              context,
                            ).scale(13) >
                                18;

                    if (stackButtons) {
                      return Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
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
