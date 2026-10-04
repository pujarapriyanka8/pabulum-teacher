import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/classwork/classwork_bloc.dart';
import 'package:pabulum_teacher/model/classwork_model.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class ClassworkScreen extends StatelessWidget {
  const ClassworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: Utils.customAppBar(
        'Classwork',
        context,
        isBack: true,
        onBackPress: () => Navigator.of(context).pop(),
      ),
      body: BlocProvider(
        create: (_) => ClassworkBloc()
          ..add(const ClassworkEvent.onLoadClasswork()),
        child: BlocBuilder<ClassworkBloc, ClassworkState>(
          builder: (context, state) {
            return SafeArea(
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
                              'Manage classwork shared with students',
                              style: TextStyle(
                                color: Color(0xFF7A879D),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 18),

                            _buildSearch(context, state),
                            const SizedBox(height: 18),

                            _buildListHeading(context, state),
                            const SizedBox(height: 14),
                          ],
                        ),
                      ),

                      Expanded(
                        child: state.isLoading
                            ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF168B80),
                            strokeWidth: 2.5,
                          ),
                        )
                            : state.arrClasswork.isEmpty
                            ? _buildEmptyState(context, state)
                            : NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification.depth == 0 &&
                                notification
                                is ScrollEndNotification &&
                                notification.metrics.extentAfter <
                                    250) {
                              _loadNextPage(context);
                            }

                            return false;
                          },
                          child: ListView.builder(
                            keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior
                                .onDrag,
                            padding: const EdgeInsets.fromLTRB(
                              16,
                              0,
                              16,
                              20,
                            ),
                            itemCount:
                            state.arrClasswork.length + 1,
                            itemBuilder: (context, index) {
                              if (index ==
                                  state.arrClasswork.length) {
                                return _buildPaginationFooter(
                                  context,
                                  state,
                                );
                              }

                              final item =
                              state.arrClasswork[index];

                              return Padding(
                                key: ValueKey(
                                  item.id ?? 'classwork-$index',
                                ),
                                padding: const EdgeInsets.only(
                                  bottom: 14,
                                ),
                                child: _buildClassworkCard(
                                  context,
                                  item,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearch(
      BuildContext context,
      ClassworkState state,
      ) {
    return TextField(
      controller: state.searchController,
      onChanged: (value) {
        context.read<ClassworkBloc>().add(
          ClassworkEvent.onLoadClasswork(
            page: 1,
            query: value,
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
        hintText: 'Search classwork title',
        hintStyle: const TextStyle(
          color: Color(0xFF929BAD),
          fontSize: 14,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Color(0xFF69758D),
          size: 23,
        ),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: state.searchController,
          builder: (context, value, child) {
            if (value.text.isEmpty) return const SizedBox.shrink();

            return IconButton(
              tooltip: 'Clear search',
              onPressed: () {
                state.searchController.clear();

                context.read<ClassworkBloc>().add(
                  const ClassworkEvent.onLoadClasswork(),
                );
              },
              icon: const Icon(
                Icons.close_rounded,
                color: Color(0xFF69758D),
                size: 21,
              ),
            );
          },
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        enabledBorder: _searchBorder(),
        focusedBorder: _searchBorder(
          color: const Color(0xFF168B80),
        ),
      ),
    );
  }

  OutlineInputBorder _searchBorder({
    Color color = const Color(0xFFDDE3ED),
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _buildListHeading(
      BuildContext context,
      ClassworkState state,
      ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final heading = Text(
          state.query.isEmpty ? 'All classwork' : 'Search results',
          style: const TextStyle(
            color: Color(0xFF19243B),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        );

        final addButton = FilledButton.icon(
          onPressed: () async {
            FocusScope.of(context).unfocus();

            final saved = await Navigator.of(context).pushNamed(
              RouteName.addHomeworkScreen,
              arguments: true,
            );
            if (saved == true && context.mounted) {
              final bloc = context.read<ClassworkBloc>();

              bloc.add(
                ClassworkEvent.onLoadClasswork(
                  query: bloc.state.searchController.text,
                ),
              );
            }
          },
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF168B80),
            foregroundColor: Colors.white,
            minimumSize: const Size(48, 48),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.add_rounded, size: 20),
          label: const Text(
            'Add Classwork',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        );

        final stackHeading = constraints.maxWidth < 300 ||
            MediaQuery.textScalerOf(context).scale(13) > 18;

        if (stackHeading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heading,
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: addButton,
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: heading),
            const SizedBox(width: 10),
            addButton,
          ],
        );
      },
    );
  }

  void _loadNextPage(BuildContext context) {
    final bloc = context.read<ClassworkBloc>();
    final state = bloc.state;

    if (state.isLoading ||
        state.isLoadingMore ||
        !state.hasMore ||
        state.currentPage == 0 ||
        state.searchController.text.trim() != state.query) {
      return;
    }

    bloc.add(
      ClassworkEvent.onLoadClasswork(
        page: state.currentPage + 1,
        query: state.query,
      ),
    );
  }

  Widget _buildPaginationFooter(
      BuildContext context,
      ClassworkState state,
      ) {
    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: Color(0xFF168B80),
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }

    if (!state.hasMore) return const SizedBox.shrink();

    return Center(
      child: TextButton(
        onPressed: () => _loadNextPage(context),
        child: const Text('Load more classwork'),
      ),
    );
  }

  Widget _buildClassworkCard(
      BuildContext context,
      ClassworkData item,
      ) {
    final colors = _cardColors(item.id);
    final background = colors[0].withOpacity(0.5);
    final header = colors[1];
    final accent = colors[2];

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
        border: Border(
          top: BorderSide(color: accent, width: 4),
          left: BorderSide(color: accent, width: 1),
          right: BorderSide(color: accent, width: 1),
          bottom: BorderSide(color: accent, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSubjectHeader(
            item,
            header: header,
            accent: accent,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTitleActions(context, item),
                Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 12),
                  child: Divider(
                    height: 1,
                    color: accent.withAlpha(40),
                  ),
                ),
                _buildLessonTopicRow(item, accent),
              ],
            ),
          ),
          _buildDateFooter(
            item.date,
            background: header.withAlpha(160),
            accent: accent,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectHeader(
      ClassworkData item, {
        required Color header,
        required Color accent,
      }) {
    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
        color: header,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: accent.withAlpha(28),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  Icons.menu_book_rounded,
                  color: accent,
                  size: 21,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  _displayText(item.subject?.name),
                  style: const TextStyle(
                    color: Color(0xFF19243B),
                    fontSize: 15,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth * 0.44,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withAlpha(22),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    '${_displayText(item.standard?.name)}'
                        ' • ${_displayText(item.division?.name)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: accent,
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

  Widget _buildTitleActions(
      BuildContext context,
      ClassworkData item,
      ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final title = Text(
          _displayText(item.title),
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
            _buildAction(
              label: 'View',
              icon: Icons.visibility_outlined,
              color: const Color(0xFF1769B5),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteName.classworkDetailScreen,
                  arguments: item.id,
                );
              },
            ),
            _buildAction(
              label: 'Delete',
              icon: Icons.delete_outline_rounded,
              color: const Color(0xFFD34460),
              onTap: () => _confirmDelete(context, item),
            ),
          ],
        );

        final stackActions = constraints.maxWidth < 290 ||
            MediaQuery.textScalerOf(context).scale(13) > 18;

        if (stackActions) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 7),
              title,
              Align(
                alignment: Alignment.centerRight,
                child: actions,
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: title),
            const SizedBox(width: 6),
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
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
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

  Widget _buildLessonTopicRow(
      ClassworkData item,
      Color accent,
      ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildField(
              label: 'Lesson',
              value: item.lesson?.name,
              icon: Icons.menu_book_outlined,
              accent: accent,
            ),
          ),
          VerticalDivider(
            width: 21,
            thickness: 1,
            color: accent.withAlpha(40),
          ),
          Expanded(
            child: _buildField(
              label: 'Topic',
              value: item.topic?.name,
              icon: Icons.lightbulb_outline_rounded,
              accent: accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String? value,
    required IconData icon,
    required Color accent,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 17),
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
        const SizedBox(height: 6),
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

  Widget _buildDateFooter(
      String? date, {
        required Color background,
        required Color accent,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 11,
      ),
      color: background,
      child: Row(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            color: accent,
            size: 19,
          ),
          const SizedBox(width: 8),
          const Text(
            'Date',
            style: TextStyle(
              color: Color(0xFF748097),
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _displayText(date),
              style: const TextStyle(
                color: Color(0xFF24314A),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
      BuildContext context,
      ClassworkState state,
      ) {
    final failedToLoad = state.currentPage == 0;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('📝', style: TextStyle(fontSize: 38)),
            const SizedBox(height: 12),
            Text(
              failedToLoad
                  ? 'Classwork could not be loaded.'
                  : state.query.isNotEmpty
                  ? 'No matching classwork'
                  : 'No classwork available',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF19243B),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (failedToLoad) ...[
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () {
                  context.read<ClassworkBloc>().add(
                    ClassworkEvent.onLoadClasswork(
                      query: state.searchController.text,
                    ),
                  );
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showDetails(
      BuildContext context,
      ClassworkData item,
      ) {
    final colors = _cardColors(item.id);

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: colors[0],
          surfaceTintColor: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 6, 4),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Classwork details',
                          style: TextStyle(
                            color: Color(0xFF19243B),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Close',
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildSubjectHeader(
                          item,
                          header: colors[1],
                          accent: colors[2],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                _displayText(item.title),
                                style: const TextStyle(
                                  color: Color(0xFF19243B),
                                  fontSize: 19,
                                  height: 1.35,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 18),
                              _buildLessonTopicRow(item, colors[2]),
                            ],
                          ),
                        ),
                        _buildDateFooter(
                          item.date,
                          background: colors[1],
                          accent: colors[2],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmDelete(
      BuildContext context,
      ClassworkData item,
      ) async {
    final bloc = context.read<ClassworkBloc>();

    showDeleteClassworkDialog(
      context,
      title: item.title??'',
      classDetails: '${_displayText(item.standard?.name)}'
          ' • ${_displayText(item.division?.name)}',
      date: item.date ?? '',
      onDelete: () {
        bloc.add(
          ClassworkEvent.onDeleteClasswork(classworkId: (item.id??0).toInt()),
        );
      },
    );
  }

  Future<void> showDeleteClassworkDialog(
      BuildContext context, {
        required String title,
        required String classDetails,
        required String date,
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
                    'DELETE CLASSWORK',
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
                    'You are about to delete this classwork. '
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
                                'CLASSWORK',
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
                              const SizedBox(height: 5),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'START DATE : ',
                                    style: TextStyle(
                                      color: Color(0xFF969DB1),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    date,
                                    style: const TextStyle(
                                      color: navy,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

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
                            'Once deleted, this classwork cannot be recovered.',
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
                                'Delete Classwork',
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


  List<Color> _cardColors(num? id) {
    const palettes = [
      [
        Color(0xFFF7F2FF),
        Color(0xFFE9DFFF),
        Color(0xFF9470E8),
      ],
      [
        Color(0xFFF0FBF7),
        Color(0xFFD7F5EB),
        Color(0xFF24A88A),
      ],
      [
        Color(0xFFF1F6FF),
        Color(0xFFDEEAFE),
        Color(0xFF5A91D7),
      ],
    ];

    return palettes[(id?.toInt() ?? 0).abs() % palettes.length];
  }

  String _displayText(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? '—' : text;
  }
}