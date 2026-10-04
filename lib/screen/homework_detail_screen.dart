import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pabulum_teacher/bloc/homework/homework_bloc.dart';


import 'package:pabulum_teacher/model/homework_detail_model.dart';
import 'package:pabulum_teacher/screen/attachment_section.dart';
import 'package:pabulum_teacher/utils/constants.dart';
import 'package:pabulum_teacher/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_color.dart';

class HomeworkDetailScreen extends StatelessWidget {
  const HomeworkDetailScreen({
    super.key,
  });


  static const _navy = Color(0xFF192841);
  static const _purple = Color(0xFF7051CC);
  static const _muted = Color(0xFF7B8498);
  static const _divider = Color(0xFFECE8F5);

  @override
  Widget build(BuildContext context) {
    final homeworkId =
    ModalRoute.of(context)!.settings.arguments as num;
    return BlocProvider(
      create: (_) => HomeworkBloc()
        ..add(
          HomeworkEvent.onLoadHomeworkDetail(
            homeworkId: homeworkId.toString(),
          ),
        ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: _navy,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Assignment Details',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: BlocBuilder<HomeworkBloc, HomeworkState>(
            builder: (context, state) {
              final detail = state.homeworkDetailData;

              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: _purple,
                  ),
                );
              }



              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildOverview(detail),
                  const SizedBox(height: 16),

                  _buildInstructions(detail),
                  const SizedBox(height: 16),
                  _buildVideoResource(context, detail),
                  const SizedBox(height: 16),

                  // Shared with classwork and submitted assignments.
                  AttachmentsSection(
                    imageUrls: [detail?.imageUrl],
                    pdfUrl: detail?.pdfUrl,
                    audioUrl: detail?.audioUrl,
                    pdfTitle: 'Homework document',
                    audioTitle: 'Audio attachment',
                  ),

                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildVideoResource(
      BuildContext context,
      HomeworkDetailData? detail,
      ) {
    final youtubeUrl = detail?.youtubeUrl?.trim() ?? '';
    final videoUrl = detail?.videoUrl?.trim() ?? '';

    final hasYoutube = Utils.hasUrl(youtubeUrl);
    final hasVideo = Utils.hasUrl(videoUrl);

    if (!hasYoutube && !hasVideo) {
      return const SizedBox.shrink();
    }

    return _buildSection(
      title: 'Video resource',
      icon: Icons.smart_display_outlined,
      headerColor: const Color(0xFFFFE8EC),
      iconColor: const Color(0xFFD95069),
      child: Column(
        children: [
          if (hasYoutube)
            _buildResourceRow(
              icon: Icons.smart_display_rounded,
              color: const Color(0xFFE84545),
              title: 'Watch on YouTube',
              subtitle: youtubeUrl,
              action: 'Play',
              onTap: () => _openYoutubeVideo(youtubeUrl),
            ),

          if (hasYoutube && hasVideo) _buildDivider(),

          if (hasVideo)
            _buildResourceRow(
              icon: Icons.play_circle_outline_rounded,
              color: AppColors.colorPurple,
              title: 'Homework video',
              subtitle: 'Video attachment',
              action: 'Play',
              onTap: () => Utils.open(
                context,
                type: ClassworkMediaType.video,
                url: videoUrl,
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color headerColor,
    required Color iconColor,
    required Widget child,
    String? trailing,
  }) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: const Color(0x167051CC),
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: headerColor,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    title,
                    style:  TextStyle(
                      color:AppColors.navy ,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(190),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      trailing,
                      style:  TextStyle(
                        color: AppColors.navy,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildResourceRow({
    required IconData icon,
    required Color color,
    required String title,
    required String action,
    required VoidCallback onTap,
    String? subtitle,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:  TextStyle(
                      color: AppColors.navy,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style:  TextStyle(
                        color:AppColors.colorMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF0EBFC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                action,
                style:  TextStyle(
                  color: AppColors.colorPurple ,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Divider(height: 1, color: Color(0xFFEDF0F5)),
    );
  }
}
  Future<void> _openYoutubeVideo(String url) async {
    final uri = Uri.tryParse(url.trim());

    if (uri == null ||
        !uri.hasAuthority ||
        (uri.scheme != 'https' && uri.scheme != 'http')) {
      Utils.showToast('Invalid video URL.', false);
      return;
    }

    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened) {
        Utils.showToast('Unable to open this video.', false);
      }
    } catch (e) {
      Utils.showToast('Unable to open this video.', false);
      debugPrint(e.toString());
    }
  }
  Widget _buildOverview(HomeworkDetailData? detail) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: const Color(0x167051CC),
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSubjectHeader(detail),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // No maxLines or fixed height: long titles wrap.
                Text(
                  Utils.displayText(detail?.title),
                  softWrap: true,
                  style:  TextStyle(
                    color: AppColors.navy,
                    fontSize: 21,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),

                _buildLessonAndTopic(detail),
                10.height,

                _buildDates(detail),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectHeader(HomeworkDetailData? detail) {
    return Container(
      color: const Color(0xFFEDE7FC),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 13,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stackHeader = constraints.maxWidth < 240 ||
              MediaQuery.textScalerOf(context).scale(14) > 21;

          final subject = Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3DAFA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.purple,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  Utils.displayText(detail?.subject?.name),
                  softWrap: true,
                  style:  TextStyle(
                    color: AppColors.navy,
                    fontSize: 16,
                    height: 1.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );

          final classBadge = Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F3FF),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFDED4F7),
              ),
            ),
            child: Text(
              Utils.classLabel(
                standard: detail?.standard?.name,
                division: detail?.division?.name,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
              style:  TextStyle(
                color: AppColors.purple,
                fontSize: 12,
                height: 1.3,
                fontWeight: FontWeight.w600,
              ),
            ),
          );

          if (stackHeader) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                subject,
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: classBadge,
                ),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                flex: 3,
                child: subject,
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: classBadge,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLessonAndTopic(HomeworkDetailData? detail) {
    return _buildResponsivePair(
      first: _buildLearningField(
        icon: Icons.auto_stories_outlined,
        label: 'Lesson',
        value: detail?.lesson?.name,
        color: AppColors.purple,
        background: const Color(0xFFF0EBFC),
      ),
      second: _buildLearningField(
        icon: Icons.sell_outlined,
        label: 'Topic',
        value: detail?.topic?.name,
        color: const Color(0xFFB38422),
        background: const Color(0xFFFFF6E4),
      ),
    );
  }

  Widget _buildLearningField({
    required IconData icon,
    required String label,
    required String? value,
    required Color color,
    required Color background,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 19,
              color: color,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style:  TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),

        // Uses the full column width and grows with the content.
        Text(
          Utils.displayText(value),
          softWrap: true,
          style:  TextStyle(
            color: AppColors.navy,
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDates(HomeworkDetailData? detail) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stackDates = constraints.maxWidth < 280 ||
            MediaQuery.textScalerOf(context).scale(14) > 19;

        final startDate = Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF7F1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: _buildDateField(
            icon: Icons.calendar_month_outlined,
            label: 'Start date',
            value: detail?.startDate,
            color: const Color(0xFF16847B),
            background: const Color(0xFFD6EEE5),
          ),
        );

        final dueDate = Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0F3),
            borderRadius: BorderRadius.circular(14),
          ),
          child: _buildDateField(
            icon: Icons.schedule_rounded,
            label: 'Due date',
            value: detail?.dueDate,
            color: const Color(0xFFC74C60),
            background: const Color(0xFFFADDE4),
          ),
        );

        if (stackDates) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              startDate,
              const SizedBox(height: 10),
              dueDate,
            ],
          );
        }

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: startDate),
              const SizedBox(width: 10),
              Expanded(child: dueDate),
            ],
          ),
        );
      },
    );
  }
  Widget _buildDateField({
    required IconData icon,
    required String label,
    required String? value,
    required Color color,
    required Color background,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            color: color,
            size: 21,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:  TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                Utils.formatDate(value),
                softWrap: true,
                style:  TextStyle(
                  color:AppColors.navy,
                  fontSize: 13,
                  height: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResponsivePair({
    required Widget first,
    required Widget second,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stackFields = constraints.maxWidth < 280 ||
            MediaQuery.textScalerOf(context).scale(14) > 19;

        if (stackFields) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              first,
              const SizedBox(height: 16),
              second,
            ],
          );
        }

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: first),

              Expanded(child: second),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInstructions(HomeworkDetailData? detail) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: const Color(0x167051CC),
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Flush header: no padding outside the colored area.
          Container(
            color: const Color(0xFFEDE7FC),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3DAFA),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Icon(
                    Icons.edit_note_rounded,
                    color: AppColors.purple,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 10),
                 Expanded(
                  child: Text(
                    'Instructions',
                    style: TextStyle(
                      color: AppColors.navy,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              // Change "text" if your model uses "description".
              Utils.displayText(detail?.text),
              softWrap: true,
              style: const TextStyle(
                color: Color(0xFF4F5D75),
                fontSize: 14,
                height: 1.65,
              ),
            ),
          ),
        ],
      ),
    );
  }
