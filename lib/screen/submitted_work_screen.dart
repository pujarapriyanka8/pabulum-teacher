
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:pabulum_teacher/bloc/submittedwork/submitted_work_bloc.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class SubmittedHomeworkScreen extends StatelessWidget {
  const SubmittedHomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (_) => SubmittedHomeworkBloc()
          ..add(
            const SubmittedHomeworkEvent.onLoadSubmittedHomework(),
          ),
        child: BlocBuilder<
            SubmittedHomeworkBloc,
            SubmittedHomeworkState>(
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
                              title: 'Submitted Homework',
                              subtitle:
                              'Review homework submitted\nby your students.',
                              image:
                              AppImages.icSubmittedHeader,
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
                                _buildSearch(
                                  context,
                                  state,
                                ),
                                const SizedBox(height: 17),
                                _buildListHeading(state),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                          Expanded(
                            child: _buildContent(
                              context,
                              state,
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
      SubmittedHomeworkState state,
      ) {
    return TextField(
      controller: state.searchController,
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        context.read<SubmittedHomeworkBloc>().add(
          SubmittedHomeworkEvent
              .onLoadSubmittedHomework(
            page: 1,
            query: value,
          ),
        );
      },
      onSubmitted: (value) {
        FocusScope.of(context).unfocus();

        context.read<SubmittedHomeworkBloc>().add(
          SubmittedHomeworkEvent
              .onLoadSubmittedHomework(
            page: 1,
            query: value,
          ),
        );
      },
      style: TextStyle(
        color: AppColors.ink,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: 'Search student name, roll no...',
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

                context.read<SubmittedHomeworkBloc>().add(
                  const SubmittedHomeworkEvent
                      .onLoadSubmittedHomework(),
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
      SubmittedHomeworkState state,
      ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            state.query.isEmpty
                ? 'All submissions'
                : 'Search results',
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(
      BuildContext context,
      SubmittedHomeworkState state,
      ) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.purple,
          strokeWidth: 2.5,
        ),
      );
    }

    if (state.arrSubmittedHomework.isEmpty) {
      return _buildEmptyState(context, state);
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.depth == 0 &&
            notification is ScrollEndNotification &&
            notification.metrics.extentAfter < 250 &&
            state.errorMessage == null) {
          _loadNextPage(context);
        }

        return false;
      },
      child: ListView.builder(
        keyboardDismissBehavior:
        ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          20,
        ),
        itemCount:
        state.arrSubmittedHomework.length + 1,
        itemBuilder: (context, index) {
          if (index ==
              state.arrSubmittedHomework.length) {
            return _buildPaginationFooter(
              context,
              state,
            );
          }

          return Padding(
            key: ValueKey(
              state.arrSubmittedHomework[index].id ??
                  'submission-$index',
            ),
            padding:
            const EdgeInsets.only(bottom: 12),
            child: _buildSubmissionCard(
              context,
              index,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmissionCard(
      BuildContext context,
      int index,
      ) {
    final item = context
        .read<SubmittedHomeworkBloc>()
        .state
        .arrSubmittedHomework[index];

    final accent =
    Utils.getCardBorderColor(index);

    final background =
    Utils.getCardBackgroundColor(index);

    final rollNumber =
        item.student?.rollNumber?.trim() ?? '';

    final grNumber =
        item.student?.grNumber?.trim() ?? '';

    final studentInfo = [
      if (rollNumber.isNotEmpty)
        'Roll: $rollNumber',
      if (grNumber.isNotEmpty)
        'GR: $grNumber',
    ].join(' • ');

    final classInfo = [
      item.homework?.standard?.name?.trim() ?? '',
      item.homework?.division?.name?.trim() ?? '',
    ].where((value) => value.isNotEmpty).join(' • ');

    final subject =
        item.homework?.subject?.name?.trim() ?? '';

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
        padding: const EdgeInsets.fromLTRB(
          12,
          12,
          12,
          12,
        ),
        decoration: BoxDecoration(
          color: background.withValues(
            alpha: 0.88,
          ),
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
            _buildStudentRow(
              name: _displayText(
                item.student?.name,
              ),
              profileImage:
              item.student?.profileImage ?? '',
              studentInfo: studentInfo,
              classInfo: classInfo,
              accent: accent,
              onView: () {
                Navigator.pushNamed(
                  context,
                  RouteName
                      .submittedHomeworkDetailScreen,
                  arguments: item.id,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 11,
              ),
              child: Divider(
                height: 1,
                thickness: 1,
                color: accent.withValues(
                  alpha: 0.20,
                ),
              ),
            ),
            Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  color: accent,
                  size: 23,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displayText(
                          item.homework?.title,
                        ),
                        maxLines: 2,
                        overflow:
                        TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.ink,
                          fontSize: 15,
                          height: 1.35,
                          fontWeight:
                          FontWeight.w800,
                        ),
                      ),
                      if (subject.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          subject,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.purple,
                  size: 19,
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    _formatDate(
                      item.submittedAt,
                    ),
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildStatus(
                  item.status ?? '',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentRow({
    required String name,
    required String profileImage,
    required String studentInfo,
    required String classInfo,
    required Color accent,
    required VoidCallback onView,
  }) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        _buildAvatar(
          profileImage,
          accent,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (studentInfo.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  studentInfo,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
              if (classInfo.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  classInfo,
                  style: TextStyle(
                    color: accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 4),
        TextButton(
          onPressed: onView,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.purple,
            padding:
            const EdgeInsets.symmetric(
              horizontal: 4,
            ),
            minimumSize: const Size(48, 44),
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View',
                style: TextStyle(
                  color: AppColors.purple,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 19,
                color: AppColors.purple,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(
      String imageUrl,
      Color accent,
      ) {
    final fallback = Icon(
      Icons.person_rounded,
      color: accent,
      size: 28,
    );

    return Container(
      width: 56,
      height: 56,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: accent.withValues(
          alpha: 0.12,
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: accent.withValues(
            alpha: 0.40,
          ),
          width: 1.5,
        ),
      ),
      child: imageUrl.trim().isEmpty
          ? fallback
          : Image.network(
        imageUrl.trim(),
        fit: BoxFit.cover,
        errorBuilder:
            (_, __, ___) => fallback,
      ),
    );
  }

  Widget _buildStatus(
      String status,
      ) {
    final normalized =
    status.trim().toLowerCase();

    final Color foreground;

    if (normalized == 'checked') {
      foreground =
          Utils.getCardBorderColor(1);
    } else if (normalized == 'submitted') {
      foreground =
          Utils.getCardBorderColor(2);
    } else {
      foreground = AppColors.muted;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: foreground.withValues(
          alpha: 0.12,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            size: 8,
            color: foreground,
          ),
          const SizedBox(width: 6),
          Text(
            status.trim().isEmpty
                ? 'Status unavailable'
                : status.trim(),
            style: TextStyle(
              color: foreground,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  void _loadNextPage(
      BuildContext context,
      ) {
    final bloc =
    context.read<SubmittedHomeworkBloc>();

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
      SubmittedHomeworkEvent
          .onLoadSubmittedHomework(
        page: state.currentPage + 1,
        query: state.query,
      ),
    );
  }

  Widget _buildPaginationFooter(
      BuildContext context,
      SubmittedHomeworkState state,
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
        onPressed: () =>
            _loadNextPage(context),
        child: Text(
          state.errorMessage == null
              ? 'Load more submissions'
              : 'Retry loading',
          style: TextStyle(
            color: AppColors.purple,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
      BuildContext context,
      SubmittedHomeworkState state,
      ) {
    final failedToLoad =
        state.errorMessage != null;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.purple
                    .withValues(alpha: 0.10),
                borderRadius:
                BorderRadius.circular(22),
              ),
              child: Icon(
                failedToLoad
                    ? Icons.cloud_off_rounded
                    : Icons.assignment_turned_in_rounded,
                color: AppColors.purple,
                size: 36,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              failedToLoad
                  ? 'Submitted homework could not be loaded.'
                  : state.query.isNotEmpty
                  ? 'No matching submissions'
                  : 'No submitted homework available',
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
                  context
                      .read<SubmittedHomeworkBloc>()
                      .add(
                    SubmittedHomeworkEvent
                        .onLoadSubmittedHomework(
                      page: 1,
                      query: state
                          .searchController.text,
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

  String _formatDate(
      String? value,
      ) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) return '—';

    final date =
    DateTime.tryParse(text);

    return date == null
        ? text
        : DateFormat('dd-MM-yyyy').format(date);
  }

  String _displayText(
      String? value,
      ) {
    final text = value?.trim() ?? '';

    return text.isEmpty
        ? '—'
        : text;
  }
}
