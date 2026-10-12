
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:pabulum_teacher/bloc/submittedwork/submitted_work_bloc.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class SubmittedHomeworkDetailScreen extends StatelessWidget {
  const SubmittedHomeworkDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final submittedHomeworkId =
    ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider(
      create: (_) => SubmittedHomeworkBloc()
        ..add(
          SubmittedHomeworkEvent.onLoadSubmittedHomeworkDetail(
            submittedHomeworkId: submittedHomeworkId,
          ),
        ),
      child: BlocConsumer<
          SubmittedHomeworkBloc,
          SubmittedHomeworkState>(
        listenWhen: (previous, current) =>
        !previous.isSubmitted && current.isSubmitted,
        listener: (context, state) {
          Navigator.of(context).pop(true);
        },
        builder: (context, state) {
          return PopScope(
            canPop: !state.isSubmitting,
            child: Scaffold(
              backgroundColor: AppColors.background,
              body: Stack(
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
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: CustomAppBar(
                                title: 'Submission Details',
                                subtitle:
                                'View student homework\nand submit your review.',
                                image: AppImages.icSubmittedDetailHeader,
                                onBack: () {
                                  if (!state.isSubmitting) {
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: _buildBody(
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
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
      BuildContext context,
      SubmittedHomeworkState state,
      ) {
    if (state.isLoadingDetail) {
      return Center(
        child: CircularProgressIndicator(
          color: AppColors.purple,
          strokeWidth: 2.5,
        ),
      );
    }

    if (state.submittedHomeworkDetailData == null) {
      return _buildErrorState();
    }

    return SingleChildScrollView(
      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(
        16,
        0,
        16,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStudentHeader(context),
          const SizedBox(height: 13),
          _buildHomeworkSection(context),
          const SizedBox(height: 13),
          _buildAnswerSection(context),
          const SizedBox(height: 13),
          _buildReviewSection(context, state),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 68,
              height: 68,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.purple.withValues(
                  alpha: 0.10,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                color: AppColors.purple,
                size: 34,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Unable to load submission details.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentHeader(BuildContext context) {
    final detail = context
        .read<SubmittedHomeworkBloc>()
        .state
        .submittedHomeworkDetailData!;

    final studentInfo = [
      if (detail.data?.student?.rollNumber?.isNotEmpty == true)
        'Roll: ${detail.data?.student?.rollNumber}',
      if (detail.data?.student?.grNumber?.isNotEmpty == true)
        'GR: ${detail.data?.student?.grNumber}',
    ].join(' • ');

    final classInfo = [
      detail.data?.homework?.standard?.name ?? '',
      detail.data?.homework?.division?.name ?? '',
    ].where((value) => value.trim().isNotEmpty).join(' • ');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.purple.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(
            detail.data?.student?.profileImage ?? '',
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _display(detail.data?.student?.name ?? ''),
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (studentInfo.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    studentInfo,
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ],
                if (classInfo.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    classInfo,
                    style: TextStyle(
                      color: AppColors.purple,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
                const SizedBox(height: 9),
                _buildStatus(
                  detail.data?.status ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String imageUrl) {
    final fallback = Icon(
      Icons.person_rounded,
      color: AppColors.purple,
      size: 34,
    );

    return Container(
      width: 62,
      height: 62,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.35),
          width: 1.5,
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

  Widget _buildHomeworkSection(BuildContext context) {
    final detail = context
        .read<SubmittedHomeworkBloc>()
        .state
        .submittedHomeworkDetailData!;

    return _buildSection(
      title: 'Homework details',
      icon: Icons.menu_book_rounded,
      accent: Utils.getCardBorderColor(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _display(detail.data?.homework?.title ?? ''),
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 17,
              height: 1.35,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          _buildField(
            'Subject',
            detail.data?.homework?.subject?.name ?? '',
          ),
          const SizedBox(height: 11),
          _buildField(
            'Lesson',
            detail.data?.homework?.lesson?.name ?? '',
          ),
          const SizedBox(height: 11),
          _buildField(
            'Topic',
            detail.data?.homework?.topic?.name ?? '',
          ),
          const SizedBox(height: 14),
          Divider(
            height: 1,
            color: AppColors.colorGrey1,
          ),
          const SizedBox(height: 14),
          _buildFieldPair(
            'Start date',
            detail.data?.homework?.startDate ?? '',
            'Due date',
            detail.data?.homework?.dueDate ?? '',
          ),
          const SizedBox(height: 15),
          _buildFieldPair(
            'Submitted on',
            detail.data?.submittedAt ?? '',
            'Last checked',
            detail.data?.checkedAt ?? '',
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerSection(BuildContext context) {
    final detail = context
        .read<SubmittedHomeworkBloc>()
        .state
        .submittedHomeworkDetailData!;

    final answer = detail.data?.answer ?? '';

    return _buildSection(
      title: 'Student answer',
      icon: Icons.assignment_rounded,
      accent: Utils.getCardBorderColor(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLabel('Text answer'),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: _fieldDecoration(),
            child: SelectableText(
              answer.isEmpty
                  ? 'No text answer provided.'
                  : answer,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
          if (detail.data?.audioUrl?.isNotEmpty == true) ...[
            const SizedBox(height: 16),
            _buildLabel('Audio answer'),
            const SizedBox(height: 8),
            Material(
              color: AppColors.purple.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(13),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => _openAudio(
                  detail.data?.audioUrl ?? '',
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_circle_outline_rounded,
                        color: AppColors.purple,
                        size: 36,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Open audio answer',
                              style: TextStyle(
                                color: AppColors.ink,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Listen in your browser or audio app',
                              style: TextStyle(
                                color: AppColors.muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.open_in_new_rounded,
                        color: AppColors.purple,
                        size: 19,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          if (detail.data?.images?.isNotEmpty == true) ...[
            const SizedBox(height: 16),
            _buildLabel(
              'Images (${detail.data?.images?.length})',
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns =
                constraints.maxWidth > 450 ? 3 : 2;

                final width =
                    (constraints.maxWidth - (columns - 1) * 10) /
                        columns;

                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: detail.data?.images?.map<Widget>(
                        (image) {
                      final url =
                          image.filePath?.trim() ?? '';

                      if (url.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return SizedBox(
                        width: width,
                        height: 115,
                        child: Material(
                          color: AppColors.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                            side: BorderSide(
                              color: AppColors.colorGrey1,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () =>
                                _showImage(context, url),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) => Icon(
                                    Icons.broken_image_outlined,
                                    color: AppColors.muted,
                                    size: 29,
                                  ),
                                ),
                                Positioned(
                                  bottom: 6,
                                  right: 6,
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor:
                                    AppColors.surface,
                                    child: Icon(
                                      Icons.zoom_in_rounded,
                                      color: AppColors.purple,
                                      size: 19,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList() ??
                      <Widget>[],
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReviewSection(
      BuildContext context,
      SubmittedHomeworkState state,
      ) {
    final disabled =
        state.isSubmitting || state.isSubmitted;

    return _buildSection(
      title: 'Teacher review',
      icon: Icons.rate_review_rounded,
      accent: Utils.getCardBorderColor(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildLabel('Comment'),
          const SizedBox(height: 8),
          TextField(
            controller: state.commentController,
            enabled: !disabled,
            minLines: 3,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 14,
              height: 1.4,
            ),
            decoration: InputDecoration(
              hintText: 'Add your remarks (optional)',
              hintStyle: TextStyle(
                color: AppColors.muted,
                fontSize: 13,
              ),
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.all(12),
              border: _inputBorder(),
              enabledBorder: _inputBorder(),
              disabledBorder: _inputBorder(),
              focusedBorder: _inputBorder(
                color: AppColors.purple,
              ),
            ),
          ),
          const SizedBox(height: 15),
          _buildLabel('Update status'),
          const SizedBox(height: 8),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12),
            decoration: _fieldDecoration(),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: state.selectedStatus,
                isExpanded: true,
                dropdownColor: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                style: TextStyle(
                  color: AppColors.ink,
                  fontSize: 14,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.purple,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Submitted',
                    child: Text('Submitted'),
                  ),
                  DropdownMenuItem(
                    value: 'Checked',
                    child: Text('Checked'),
                  ),
                ],
                onChanged: disabled
                    ? null
                    : (value) {
                  if (value == null) return;

                  context
                      .read<SubmittedHomeworkBloc>()
                      .add(
                    SubmittedHomeworkEvent
                        .onSelectReviewStatus(
                      status: value,
                    ),
                  );
                },
              ),
            ),
          ),
          if (state.reviewErrorMessage?.isNotEmpty == true) ...[
            const SizedBox(height: 11),
            Text(
              state.reviewErrorMessage!,
              style: TextStyle(
                color: Utils.getCardBorderColor(3),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 17),
          SizedBox(
            height: 49,
            child: ElevatedButton(
              onPressed: disabled
                  ? null
                  : () {
                FocusScope.of(context).unfocus();

                context
                    .read<SubmittedHomeworkBloc>()
                    .add(
                  const SubmittedHomeworkEvent
                      .onSubmitReview(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                foregroundColor: AppColors.white,
                disabledBackgroundColor:
                AppColors.purple.withValues(alpha: 0.45),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: state.isSubmitting
                  ? SizedBox(
                width: 21,
                height: 21,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2,
                ),
              )
                  : Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.send_rounded,
                    size: 19,
                  ),
                  const SizedBox(width: 9),
                  Text(
                    'Submit review',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color accent,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: accent.withValues(alpha: 0.24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 12,
            ),
            color: accent.withValues(alpha: 0.11),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: accent,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Column(
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
          _display(value),
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 14,
            height: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFieldPair(
      String firstLabel,
      String firstValue,
      String secondLabel,
      String secondValue,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildDateInfo(firstLabel, firstValue),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDateInfo(secondLabel, secondValue),
        ),
      ],
    );
  }

  Widget _buildDateInfo(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.calendar_month_rounded,
          color: AppColors.purple,
          size: 19,
        ),
        const SizedBox(width: 7),
        Expanded(
          child: _buildField(label, value),
        ),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: AppColors.ink,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  BoxDecoration _fieldDecoration() {
    return BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: AppColors.colorGrey1,
      ),
    );
  }

  OutlineInputBorder _inputBorder({
    Color? color,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: color ?? AppColors.colorGrey1,
      ),
    );
  }

  Widget _buildStatus(String status) {
    final checked =
        status.trim().toLowerCase() == 'checked';

    final color = checked
        ? Utils.getCardBorderColor(1)
        : Utils.getCardBorderColor(2);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            size: 8,
            color: color,
          ),
          const SizedBox(width: 7),
          Text(
            _display(status),
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openAudio(String url) async {
    final uri = Uri.tryParse(url.trim());

    if (uri == null ||
        !uri.hasAuthority ||
        (uri.scheme != 'https' && uri.scheme != 'http')) {
      Utils.showToast('Invalid audio URL.', false);
      return;
    }

    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened) {
        Utils.showToast('Unable to open this audio.', false);
      }
    } catch (e) {
      Utils.showToast('Unable to open this audio.', false);
      debugPrint(e.toString());
    }
  }

  void _showImage(BuildContext context, String url) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog.fullscreen(
          backgroundColor: AppColors.colorBlack,
          child: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 5,
                    child: Center(
                      child: Image.network(
                        url,
                        fit: BoxFit.contain,
                        loadingBuilder:
                            (context, child, progress) {
                          if (progress == null) {
                            return child;
                          }

                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          );
                        },
                        errorBuilder: (_, __, ___) => Center(
                          child: Text(
                            'Unable to load image.',
                            style: TextStyle(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    tooltip: 'Close',
                    onPressed: () =>
                        Navigator.of(dialogContext).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.white,
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

  String _display(String value) {
    final text = value.trim();
    return text.isEmpty ? '—' : text;
  }
}
