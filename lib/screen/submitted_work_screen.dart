import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:pabulum_teacher/bloc/submittedwork/submitted_work_bloc.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class SubmittedHomeworkScreen extends StatelessWidget {
  const SubmittedHomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: Utils.customAppBar(
        'Submitted Homework',
        context,
        isBack: true,
        onBackPress: () => Navigator.of(context).pop(),
      ),
      body: BlocProvider(
        create: (_) => SubmittedHomeworkBloc()
          ..add(
            const SubmittedHomeworkEvent.onLoadSubmittedHomework(),
          ),
        child: BlocBuilder<SubmittedHomeworkBloc, SubmittedHomeworkState>(
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
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSearch(context, state),
                            const SizedBox(height: 16),
                            Text(
                              state.query.isEmpty
                                  ? 'All submissions'
                                  : 'Search results',
                              style: TextStyle(
                                color: AppColors.navy,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                      Expanded(
                        child: _buildContent(context, state),
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
      SubmittedHomeworkState state,
      ) {
    return TextField(
      controller: state.searchController,
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        context.read<SubmittedHomeworkBloc>().add(
          SubmittedHomeworkEvent.onLoadSubmittedHomework(
            page: 1,
            query: value,
          ),
        );
      },
      onSubmitted: (value) {
        FocusScope.of(context).unfocus();

        context.read<SubmittedHomeworkBloc>().add(
          SubmittedHomeworkEvent.onLoadSubmittedHomework(
            page: 1,
            query: value,
          ),
        );
      },
      style: TextStyle(
        color: AppColors.navy,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: 'Search student name, roll no…',
        hintStyle: const TextStyle(
          color: Color(0xFF929BAD),
          fontSize: 13,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Color(0xFF69758D),
          size: 22,
        ),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
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
                  const SubmittedHomeworkEvent.onLoadSubmittedHomework(),
                );
              },
              icon: const Icon(
                Icons.close_rounded,
                color: Color(0xFF69758D),
                size: 20,
              ),
            );
          },
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        enabledBorder: _searchBorder(),
        focusedBorder: _searchBorder(color: AppColors.purple),
      ),
    );
  }

  OutlineInputBorder _searchBorder({
    Color color = const Color(0xFFE1E5EF),
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color),
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
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        itemCount: state.arrSubmittedHomework.length + 1,
        itemBuilder: (context, index) {
          if (index == state.arrSubmittedHomework.length) {
            return _buildPaginationFooter(context, state);
          }

          return Padding(
            key: ValueKey(
              state.arrSubmittedHomework[index].id ?? 'submission-$index',
            ),
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildSubmissionCard(context, index),
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

    final colors = _cardColors((item.id ?? 0).toInt());
    final background = colors[0];
    final accent = colors[1];

    final rollNumber = item.student?.rollNumber?.trim() ?? '';
    final grNumber = item.student?.grNumber?.trim() ?? '';

    final studentInfo = [
      if (rollNumber.isNotEmpty) 'Roll: $rollNumber',
      if (grNumber.isNotEmpty) 'GR: $grNumber',
    ].join(' • ');

    final classInfo = [
      item.homework?.standard?.name?.trim() ?? '',
      item.homework?.division?.name?.trim() ?? '',
    ].where((value) => value.isNotEmpty).join(' • ');

    final subject = item.homework?.subject?.name?.trim() ?? '';

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: background.withAlpha(128),
        borderRadius: BorderRadius.circular(16),
        border: Border(
          top: BorderSide(
            color: accent,
            width: 3,
          ),
          left: BorderSide(
            color: accent,
            width: 1,
          ),
          right: BorderSide(
            color: accent,
            width: 1,
          ),
          bottom: BorderSide(
            color: accent,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Student details and View action.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(
                item.student?.profileImage ?? '',
                accent,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _displayText(item.student?.name),
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 15,
                        height: 1.3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (studentInfo.isNotEmpty) ...[
                      const SizedBox(height: 3),
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
                      const SizedBox(height: 3),
                      Text(
                        classInfo,
                        style: TextStyle(
                          color: accent,
                          fontSize: 12,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 4),
              TextButton(
                onPressed: () => {
                  Navigator.pushNamed(
                    context,
                    RouteName.submittedHomeworkDetailScreen,
                    arguments: item.id,
                  )
                },
                style: TextButton.styleFrom(
                  foregroundColor: accent,
                  minimumSize: const Size(48, 48),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(
              height: 1,
              thickness: 1,
              color: accent.withAlpha(30),
            ),
          ),

          // Homework title and subject.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.menu_book_outlined,
                  color: accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _displayText(item.homework?.title),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.navy,
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subject.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        subject,
                        style: TextStyle(
                          color: AppColors.muted,
                          fontSize: 12,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Compact date and status footer.
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.muted,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      _formatDate(item.submittedAt),
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              _buildStatus(item.status ?? ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String imageUrl, Color accent) {
    final fallback = Icon(
      Icons.person_outline_rounded,
      color: accent,
      size: 25,
    );

    return Container(
      width: 40,
      height: 40,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: accent.withAlpha(18),
        shape: BoxShape.circle,
        border: Border.all(
          color: accent.withAlpha(40),
        ),
      ),
      child: imageUrl.trim().isEmpty
          ? fallback
          : Image.network(
        imageUrl.trim(),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => fallback,
      ),
    );
  }

  Widget _buildStatus(String status) {
    final normalized = status.trim().toLowerCase();

    final Color foreground;
    final Color background;

    if (normalized == 'checked') {
      foreground = const Color(0xFF168367);
      background = const Color(0xFFE3F4EC);
    } else if (normalized == 'submitted') {
      foreground = const Color(0xFF426DC5);
      background = const Color(0xFFEAF0FC);
    } else {
      foreground = AppColors.muted;
      background = const Color(0xFFF0F2F6);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            color: foreground,
            size: 5,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              status.trim().isEmpty ? 'Status unavailable' : status.trim(),
              style: TextStyle(
                color: foreground,
                fontSize: 10,
                height: 1.3,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _loadNextPage(BuildContext context) {
    final bloc = context.read<SubmittedHomeworkBloc>();
    final state = bloc.state;

    if (state.isLoading ||
        state.isLoadingMore ||
        !state.hasMore ||
        state.currentPage == 0 ||
        state.searchController.text.trim() != state.query) {
      return;
    }

    bloc.add(
      SubmittedHomeworkEvent.onLoadSubmittedHomework(
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
        onPressed: () => _loadNextPage(context),
        child: Text(
          state.errorMessage == null
              ? 'Load more submissions'
              : 'Retry loading',
        ),
      ),
    );
  }

  Widget _buildEmptyState(
      BuildContext context,
      SubmittedHomeworkState state,
      ) {
    final failedToLoad = state.errorMessage != null;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              failedToLoad
                  ? Icons.cloud_off_rounded
                  : Icons.assignment_turned_in_outlined,
              color: const Color(0xFFB8ACD8),
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              failedToLoad
                  ? 'Submitted homework could not be loaded.'
                  : state.query.isNotEmpty
                  ? 'No matching submissions'
                  : 'No submitted homework available',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.navy,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (failedToLoad) ...[
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () {
                  context.read<SubmittedHomeworkBloc>().add(
                    SubmittedHomeworkEvent.onLoadSubmittedHomework(
                      page: 1,
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

  void _showSubmission(
      BuildContext context,
      int index,
      ) {
    final item = context
        .read<SubmittedHomeworkBloc>()
        .state
        .arrSubmittedHomework[index];

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Submission summary',
                          style: TextStyle(
                            color: AppColors.navy,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Close',
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryField(
                    'Student',
                    item.student?.name ?? '',
                  ),
                  _buildSummaryField(
                    'Roll number',
                    item.student?.rollNumber ?? '',
                  ),
                  _buildSummaryField(
                    'GR number',
                    item.student?.grNumber ?? '',
                  ),
                  _buildSummaryField(
                    'Standard',
                    item.homework?.standard?.name ?? '',
                  ),
                  _buildSummaryField(
                    'Division',
                    item.homework?.division?.name ?? '',
                  ),
                  _buildSummaryField(
                    'Homework',
                    item.homework?.title ?? '',
                  ),
                  _buildSummaryField(
                    'Subject',
                    item.homework?.subject?.name ?? '',
                  ),
                  _buildSummaryField(
                    'Submitted at',
                    _formatDate(item.submittedAt),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildStatus(item.status ?? ''),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _displayText(value),
            style: TextStyle(
              color: AppColors.navy,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _cardColors(int id) {
    // Background and accent.
    const palettes = [
      [
        Color(0xFFF5F0FF),
        Color(0xFF8A62D6),
      ],
      [
        Color(0xFFEDF9F4),
        Color(0xFF279B7B),
      ],
      [
        Color(0xFFEEF5FF),
        Color(0xFF4A90D6),
      ],
    ];

    return palettes[id.abs() % palettes.length];
  }

  String _formatDate(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) return '—';

    final date = DateTime.tryParse(text);

    return date == null ? text : DateFormat('dd-MM-yyyy').format(date);
  }

  String _displayText(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? '—' : text;
  }
}