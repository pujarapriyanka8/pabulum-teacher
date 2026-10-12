
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/classwork/classwork_bloc.dart';
import 'package:pabulum_teacher/model/classwork_model.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class ClassworkScreen extends StatelessWidget {
  const ClassworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (_) => ClassworkBloc()
          ..add(const ClassworkEvent.onLoadClasswork()),
        child: BlocBuilder<ClassworkBloc, ClassworkState>(
          builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
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
                      constraints: const BoxConstraints(
                        maxWidth: 700,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: CustomAppBar(
                              title: 'Classwork',
                              subtitle:
                              'Manage classwork shared\nwith your students.',
                              image: AppImages.icClassworkHeader,
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
                                _buildSearch(context, state),
                                const SizedBox(height: 16),
                                _buildListHeading(
                                  context,
                                  state,
                                ),
                                const SizedBox(height: 13),
                              ],
                            ),
                          ),
                          Expanded(
                            child: state.isLoading
                                ? Center(
                              child:
                              CircularProgressIndicator(
                                color: AppColors.purple,
                                strokeWidth: 2.5,
                              ),
                            )
                                : state.arrClasswork.isEmpty
                                ? _buildEmptyState(
                              context,
                              state,
                            )
                                : NotificationListener<
                                ScrollNotification>(
                              onNotification:
                                  (notification) {
                                if (notification.depth ==
                                    0 &&
                                    notification
                                    is ScrollEndNotification &&
                                    notification
                                        .metrics
                                        .extentAfter <
                                        250) {
                                  _loadNextPage(
                                    context,
                                  );
                                }

                                return false;
                              },
                              child: ListView.builder(
                                keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior
                                    .onDrag,
                                padding:
                                const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  20,
                                ),
                                itemCount: state
                                    .arrClasswork
                                    .length +
                                    1,
                                itemBuilder:
                                    (context, index) {
                                  if (index ==
                                      state.arrClasswork
                                          .length) {
                                    return _buildPaginationFooter(
                                      context,
                                      state,
                                    );
                                  }

                                  final item =
                                  state.arrClasswork[
                                  index];

                                  return Padding(
                                    key: ValueKey(
                                      item.id ??
                                          'classwork-$index',
                                    ),
                                    padding:
                                    const EdgeInsets.only(
                                      bottom: 13,
                                    ),
                                    child:
                                    _buildClassworkCard(
                                      context,
                                      item,
                                      index,
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
                ),
              ],
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
      style: TextStyle(
        color: AppColors.ink,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: 'Search classwork title',
        hintStyle: TextStyle(
          color: AppColors.muted,
          fontSize: 13,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: AppColors.purple,
          size: 24,
        ),
        suffixIcon:
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: state.searchController,
          builder: (context, value, child) {
            if (value.text.isEmpty) {
              return const SizedBox.shrink();
            }

            return IconButton(
              tooltip: 'Clear search',
              onPressed: () {
                state.searchController.clear();

                context.read<ClassworkBloc>().add(
                  const ClassworkEvent
                      .onLoadClasswork(),
                );
              },
              icon: Icon(
                Icons.close_rounded,
                color: AppColors.muted,
                size: 20,
              ),
            );
          },
        ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
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

  Widget _buildListHeading(
      BuildContext context,
      ClassworkState state,
      ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final heading = Text(
          state.query.isEmpty
              ? 'All classwork'
              : 'Search results',
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        );

        final addButton = FilledButton.icon(
          onPressed: () async {
            FocusScope.of(context).unfocus();

            final saved =
            await Navigator.of(context).pushNamed(
              RouteName.addClassworkScreen,
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
            size: 20,
          ),
          label: const Text(
            'Add Classwork',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        );

        final stackHeading =
            constraints.maxWidth < 300 ||
                MediaQuery.textScalerOf(context).scale(13) >
                    18;

        if (stackHeading) {
          return Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
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
            const SizedBox(width: 8),
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
        state.searchController.text.trim() !=
            state.query) {
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
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              color: AppColors.purple,
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }

    if (!state.hasMore) {
      return const SizedBox.shrink();
    }

    return Center(
      child: TextButton(
        onPressed: () => _loadNextPage(context),
        child: Text(
          'Load more classwork',
          style: TextStyle(
            color: AppColors.purple,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildClassworkCard(
      BuildContext context,
      ClassworkData item,
      int index,
      ) {
    final accent =
    Utils.getCardBorderColor(index);

    final background =
    Utils.getCardBackgroundColor(index);

    return Container(
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(19),
      ),
      padding: const EdgeInsets.fromLTRB(
        1,
        6,
        1,
        1,
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(13),
            topRight: Radius.circular(13),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.stretch,
          children: [
            _buildSubjectHeader(
              item,
              accent: accent,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                8,
                12,
                13,
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.stretch,
                children: [
                  _buildTitleActions(
                    context,
                    item,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(
                      top: 7,
                      bottom: 12,
                    ),
                    child: Divider(
                      height: 1,
                      color: accent.withValues(
                        alpha: 0.18,
                      ),
                    ),
                  ),
                  _buildLessonTopicRow(
                    item,
                    accent,
                  ),
                ],
              ),
            ),
            _buildDateFooter(
              item.date,
              accent: accent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectHeader(
      ClassworkData item, {
        required Color accent,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 10,
      ),
      color: accent.withValues(alpha: 0.10),
      child: Row(
        children: [
          Container(
            width: 37,
            height: 37,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(
                alpha: 0.13,
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              Icons.menu_book_rounded,
              color: accent,
              size: 22,
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              _displayText(item.subject?.name),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 15,
                height: 1.3,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 7),
          ConstrainedBox(
            constraints:
            const BoxConstraints(maxWidth: 125),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: accent.withValues(
                  alpha: 0.14,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_displayText(item.standard?.name)}'
                    ' • ${_displayText(item.division?.name)}',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: accent,
                  fontSize: 11,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
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
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 16,
            height: 1.35,
            fontWeight: FontWeight.w800,
          ),
        );

        final actions = Wrap(
          spacing: 2,
          runSpacing: 2,
          children: [
            _buildAction(
              label: 'View',
              icon: Icons.visibility_outlined,
              color: Utils.getCardBorderColor(2),
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
              color: Utils.getCardBorderColor(3),
              onTap: () => _confirmDelete(
                context,
                item,
              ),
            ),
          ],
        );

        final stackActions =
            constraints.maxWidth < 290 ||
                MediaQuery.textScalerOf(context).scale(13) >
                    18;

        if (stackActions) {
          return Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
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
            const SizedBox(width: 5),
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
          Icon(icon, size: 17),
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

  Widget _buildLessonTopicRow(
      ClassworkData item,
      Color accent,
      ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
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
            width: 18,
            thickness: 1,
            color: accent.withValues(alpha: 0.18),
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
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: accent,
              size: 17,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.muted,
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
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 13,
            height: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDateFooter(
      String? date, {
        required Color accent,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 11,
      ),
      color: accent.withValues(alpha: 0.08),
      child: Row(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            color: AppColors.purple,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Date',
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _displayText(date),
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 13,
                fontWeight: FontWeight.w700,
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
            Container(
              width: 70,
              height: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.purple.withValues(
                  alpha: 0.10,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                failedToLoad
                    ? Icons.cloud_off_rounded
                    : Icons.edit_note_rounded,
                color: AppColors.purple,
                size: 35,
              ),
            ),
            const SizedBox(height: 13),
            Text(
              failedToLoad
                  ? 'Classwork could not be loaded.'
                  : state.query.isNotEmpty
                  ? 'No matching classwork'
                  : 'No classwork available',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (failedToLoad) ...[
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () {
                  context.read<ClassworkBloc>().add(
                    ClassworkEvent.onLoadClasswork(
                      query:
                      state.searchController.text,
                    ),
                  );
                },
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

  void _showDetails(
      BuildContext context,
      ClassworkData item,
      ) {
    final index = (item.id ?? 0).toInt().abs();
    final accent = Utils.getCardBorderColor(index);
    final background =
    Utils.getCardBackgroundColor(index);

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: background,
          surfaceTintColor: AppColors.surface,
          clipBehavior: Clip.antiAlias,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints:
            const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    8,
                    6,
                    4,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Classwork details',
                          style: TextStyle(
                            color: AppColors.ink,
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
                        icon: Icon(
                          Icons.close_rounded,
                          color: AppColors.ink,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                      children: [
                        _buildSubjectHeader(
                          item,
                          accent: accent,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                _displayText(item.title),
                                style: TextStyle(
                                  color: AppColors.ink,
                                  fontSize: 19,
                                  height: 1.35,
                                  fontWeight:
                                  FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 18),
                              _buildLessonTopicRow(
                                item,
                                accent,
                              ),
                            ],
                          ),
                        ),
                        _buildDateFooter(
                          item.date,
                          accent: accent,
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

    await showDeleteClassworkDialog(
      context,
      title: item.title ?? '',
      classDetails:
      '${_displayText(item.standard?.name)}'
          ' • ${_displayText(item.division?.name)}',
      date: item.date ?? '',
      onDelete: () {
        bloc.add(
          ClassworkEvent.onDeleteClasswork(
            classworkId: (item.id ?? 0).toInt(),
          ),
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
    final red = Utils.getCardBorderColor(3);

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.colorBlack.withValues(
        alpha: 0.50,
      ),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: AppColors.surface,
          surfaceTintColor: AppColors.surface,
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
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 66,
                      height: 66,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: red.withValues(
                          alpha: 0.12,
                        ),
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.delete_outline_rounded,
                        color: red,
                        size: 35,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
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
                  Text(
                    'Are you sure?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'You are about to delete this classwork. '
                        'This action cannot be undone.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: AppColors.purple.withValues(
                        alpha: 0.05,
                      ),
                      borderRadius:
                      BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.colorGrey1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.purple
                                .withValues(alpha: 0.12),
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.edit_note_rounded,
                            color: AppColors.purple,
                            size: 27,
                          ),
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CLASSWORK',
                                style: TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 11,
                                  fontWeight:
                                  FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                title,
                                style: TextStyle(
                                  color: AppColors.ink,
                                  fontSize: 15,
                                  fontWeight:
                                  FontWeight.w800,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                classDetails,
                                style: TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppColors.purple,
                                    size: 17,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      date,
                                      style: TextStyle(
                                        color: AppColors.ink,
                                        fontSize: 12,
                                        fontWeight:
                                        FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Utils.getCardBackgroundColor(4),
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Utils.getCardBorderColor(4),
                          size: 21,
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Text(
                            'Once deleted, this classwork cannot be recovered.',
                            style: TextStyle(
                              color: AppColors.ink,
                              fontSize: 12,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final cancelButton =
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.muted,
                          minimumSize: const Size(0, 48),
                          side: BorderSide(
                            color: AppColors.colorGrey1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12),
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

                      final deleteButton =
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          onDelete();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: red,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          minimumSize: const Size(0, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          size: 18,
                        ),
                        label: const Text(
                          'Delete Classwork',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
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

  String _displayText(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? '—' : text;
  }
}
