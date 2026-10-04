import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:pabulum_teacher/bloc/submittedwork/submitted_work_bloc.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class SubmittedHomeworkDetailScreen extends StatelessWidget {

  const SubmittedHomeworkDetailScreen({
    super.key,
  });

  static const _navy = Color(0xFF19243B);
  static const _muted = Color(0xFF78839B);
  static const _purple = Color(0xFF7655E8);
  static const _border = Color(0xFFE8E5F1);
  static const _background = Color(0xFFF7F8FC);

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
      child: BlocConsumer<SubmittedHomeworkBloc, SubmittedHomeworkState>(
        listenWhen: (previous, current) =>
        !previous.isSubmitted && current.isSubmitted,
        listener: (context, state) {
          Navigator.of(context).pop(true);
        },
        builder: (context, state) {
          return PopScope(
            canPop: !state.isSubmitting,
            child: Scaffold(
              backgroundColor: _background,
              appBar: Utils.customAppBar(
                'Submission Details',
                context,
                isBack: true,
                onBackPress: () {
                  if (!state.isSubmitting) {
                    Navigator.of(context).pop();
                  }
                },
              ),
              body: SafeArea(
                child: _buildBody(context, state),
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
      return const Center(
        child: CircularProgressIndicator(
          color: _purple,
          strokeWidth: 2.5,
        ),
      );
    }

    if (state.submittedHomeworkDetailData == null) {
      return _buildErrorState(context, state);
    }

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStudentHeader(context),
              const SizedBox(height: 14),
              _buildHomeworkSection(context),
              const SizedBox(height: 14),
              _buildAnswerSection(context),
              const SizedBox(height: 14),
              _buildReviewSection(context, state),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(
      BuildContext context,
      SubmittedHomeworkState state,
      ) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              color: _muted,
              size: 46,
            ),
            const SizedBox(height: 12),
            const Text(
              'Unable to load submission details.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _navy,
                fontSize: 16,
                fontWeight: FontWeight.w600,
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
      if (detail.data?.student?.rollNumber?.isNotEmpty == true) 'Roll: ${detail.data?.student?.rollNumber}',
      if (detail.data?.student?.grNumber?.isNotEmpty == true) 'GR: ${detail.data?.student?.grNumber}',
    ].join(' • ');

    final classInfo = [
      detail.data?.homework?.standard?.name??'',
      detail.data?.homework?.division?.name??'',
    ].where((value) => value.trim().isNotEmpty).join(' • ');

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3EFFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE3D9FA),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(detail.data?.student?.profileImage??''),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _display(detail.data?.student?.name??''),
                  style: const TextStyle(
                    color: _navy,
                    fontSize: 16,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (studentInfo.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    studentInfo,
                    style: const TextStyle(
                      color: _muted,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
                if (classInfo.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    classInfo,
                    style: const TextStyle(
                      color: _purple,
                      fontSize: 12,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                _buildStatus(detail.data?.status??''),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String imageUrl) {
    const fallback = Icon(
      Icons.person_outline_rounded,
      color: _purple,
      size: 28,
    );

    return Container(
      width: 46,
      height: 46,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFE3D9FA),
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
      icon: Icons.menu_book_outlined,
      color: _purple,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _display(detail.data?.homework?.title??''),
            style: const TextStyle(
              color: _navy,
              fontSize: 16,
              height: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          _buildField('Subject', detail.data?.homework?.subject?.name??''),
          const SizedBox(height: 12),
          _buildField('Lesson', detail.data?.homework?.lesson?.name??''),
          const SizedBox(height: 12),
          _buildField('Topic', detail.data?.homework?.topic?.name??''),
          const Divider(
            color: _border,
            height: 26,
          ),
          _buildFieldPair(
            'Start date',
            detail.data?.homework?.startDate??'',
            'Due date',
            detail.data?.homework?.dueDate??'',
          ),
          const SizedBox(height: 14),
          _buildFieldPair(
            'Submitted on',
            detail.data?.submittedAt??'',
            'Last checked',
            detail.data?.checkedAt??'',
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

    return _buildSection(
      title: 'Student answer',
      icon: Icons.assignment_outlined,
      color: const Color(0xFF4489CF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Text answer',
            style: TextStyle(
              color: _navy,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FD),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _border),
            ),
            child: SelectableText(
              detail.data?.answer?.isEmpty == true
                  ? 'No text answer provided.'
                  : detail.data?.answer??'',
              style: const TextStyle(
                color: _navy,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
          if (detail.data?.audioUrl?.isNotEmpty == true) ...[
            const SizedBox(height: 16),
            const Text(
              'Audio answer',
              style: TextStyle(
                color: _navy,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Material(
              color: const Color(0xFFF3EFFF),
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => _openAudio(detail.data?.audioUrl??''),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_circle_outline_rounded,
                        color: _purple,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Open audio answer',
                              style: TextStyle(
                                color: _navy,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Listen in your browser or audio app',
                              style: TextStyle(
                                color: _muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.open_in_new_rounded,
                        color: _muted,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          if (detail.data?.images?.isNotEmpty == true) ...[
            const SizedBox(height: 16),
            Text(
              'Images (${detail.data?.images?.length})',
              style: const TextStyle(
                color: _navy,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth > 450 ? 3 : 2;
                final width =
                    (constraints.maxWidth - (columns - 1) * 10) / columns;

                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: detail.data?.images?.map<Widget>((image) {
                    final url = image.filePath?.trim() ?? '';

                    if (url.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return SizedBox(
                      width: width,
                      height: 110,
                      child: Material(
                        color: const Color(0xFFF3F4F8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: _border),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => _showImage(context, url),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                url,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.broken_image_outlined,
                                  color: _muted,
                                  size: 28,
                                ),
                              ),
                              const Positioned(
                                right: 6,
                                bottom: 6,
                                child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.zoom_in_rounded,
                                    color: _navy,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList() ??
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
    final disabled = state.isSubmitting || state.isSubmitted;

    return _buildSection(
      title: 'Teacher review',
      icon: Icons.rate_review_outlined,
      color: const Color(0xFF239578),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Comment',
            style: TextStyle(
              color: _navy,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: state.commentController,
            enabled: !disabled,
            minLines: 3,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(
              color: _navy,
              fontSize: 14,
              height: 1.4,
            ),
            decoration: InputDecoration(
              hintText: 'Add your remarks (optional)',
              hintStyle: const TextStyle(
                color: _muted,
                fontSize: 13,
              ),
              filled: true,
              fillColor: const Color(0xFFFAFAFD),
              contentPadding: const EdgeInsets.all(12),
              border: _inputBorder(),
              enabledBorder: _inputBorder(),
              disabledBorder: _inputBorder(),
              focusedBorder: _inputBorder(color: _purple),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Update status',
            style: TextStyle(
              color: _navy,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: state.selectedStatus,
                isExpanded: true,
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                style: const TextStyle(
                  color: _navy,
                  fontSize: 14,
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: _muted,
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

                  context.read<SubmittedHomeworkBloc>().add(
                    SubmittedHomeworkEvent.onSelectReviewStatus(
                      status: value,
                    ),
                  );
                },
              ),
            ),
          ),
          if (state.reviewErrorMessage?.isNotEmpty == true) ...[
            const SizedBox(height: 12),
            Text(
              state.reviewErrorMessage!,
              style: const TextStyle(
                color: Color(0xFFC74758),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 18),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: disabled
                  ? null
                  : () {
                FocusScope.of(context).unfocus();

                context.read<SubmittedHomeworkBloc>().add(
                  const SubmittedHomeworkEvent.onSubmitReview(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _purple,
                foregroundColor: Colors.white,
                disabledBackgroundColor: _purple.withAlpha(130),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: state.isSubmitting
                  ? const SizedBox(
                width: 21,
                height: 21,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : const Text(
                'Submit review',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _inputBorder({
    Color color = _border,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withAlpha(20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: _navy,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: _border,
          ),
          Padding(
            padding: const EdgeInsets.all(14),
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
          style: const TextStyle(
            color: _muted,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _display(value),
          style: const TextStyle(
            color: _navy,
            fontSize: 13,
            height: 1.4,
            fontWeight: FontWeight.w500,
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
          child: _buildField(firstLabel, firstValue),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildField(secondLabel, secondValue),
        ),
      ],
    );
  }

  Widget _buildStatus(String status) {
    final checked = status.trim().toLowerCase() == 'checked';

    final color = checked
        ? const Color(0xFF168367)
        : const Color(0xFF426DC5);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        _display(status),
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
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
          backgroundColor: Colors.black,
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
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;

                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        },
                        errorBuilder: (_, __, ___) => const Center(
                          child: Text(
                            'Unable to load image.',
                            style: TextStyle(color: Colors.white),
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
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
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