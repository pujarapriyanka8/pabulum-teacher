
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:pabulum_teacher/bloc/homework/homework_bloc.dart';
import 'package:pabulum_teacher/model/homework_detail_model.dart';
import 'package:pabulum_teacher/screen/attachment_section.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/constants.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class HomeworkDetailScreen extends StatelessWidget {
  const HomeworkDetailScreen({super.key});

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
                          title: 'Homework Details',
                          subtitle:
                          'View homework details\nand learning resources.',
                          image: AppImages.icHomeworkDetailHeader,
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<
                            HomeworkBloc,
                            HomeworkState>(
                          builder: (context, state) {
                            final detail =
                                state.homeworkDetailData;

                            if (state.isLoading) {
                              return Center(
                                child:
                                CircularProgressIndicator(
                                  color: AppColors.purple,
                                ),
                              );
                            }

                            return ListView(
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
                              children: [
                                _buildOverview(detail),
                                const SizedBox(height: 16),
                                _buildInstructions(detail),
                                const SizedBox(height: 16),
                                _buildVideoResource(
                                  context,
                                  detail,
                                ),
                                const SizedBox(height: 16),
                                AttachmentsSection(
                                  imageUrls: [
                                    detail?.imageUrl,
                                  ],
                                  pdfUrl: detail?.pdfUrl,
                                  audioUrl: detail?.audioUrl,
                                  pdfTitle:
                                  'Homework document',
                                  audioTitle:
                                  'Audio attachment',
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
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
  }

  Widget _buildOverview(
      HomeworkDetailData? detail,
      ) {
    final borderColor =
    Utils.getCardBorderColor(0);

    return _buildCard(
      borderColor: borderColor,
      radius: 18,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: [
          _buildSubjectHeader(
            detail,
            borderColor,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.stretch,
              children: [
                Text(
                  Utils.displayText(detail?.title),
                  softWrap: true,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 20,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 19),
                _buildLessonAndTopic(detail),
                const SizedBox(height: 15),
                Divider(
                  height: 1,
                  color: AppColors.colorGrey1,
                ),
                const SizedBox(height: 15),
                _buildDates(detail),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectHeader(
      HomeworkDetailData? detail,
      Color borderColor,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 12,
      ),
      color: borderColor.withValues(
        alpha: 0.10,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stackHeader =
              constraints.maxWidth < 240 ||
                  MediaQuery.textScalerOf(context)
                      .scale(14) >
                      21;

          final subject = Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: borderColor.withValues(
                    alpha: 0.12,
                  ),
                  borderRadius:
                  BorderRadius.circular(11),
                ),
                child: Icon(
                  Icons.menu_book_rounded,
                  color: borderColor,
                  size: 23,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  Utils.displayText(
                    detail?.subject?.name,
                  ),
                  softWrap: true,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 15,
                    height: 1.35,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          );

          final classBadge = Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:
              BorderRadius.circular(20),
              border: Border.all(
                color: borderColor.withValues(
                  alpha: 0.30,
                ),
              ),
            ),
            child: Text(
              Utils.classLabel(
                standard:
                detail?.standard?.name,
                division:
                detail?.division?.name,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: borderColor,
                fontSize: 11,
                height: 1.3,
                fontWeight: FontWeight.w700,
              ),
            ),
          );

          if (stackHeader) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.stretch,
              children: [
                subject,
                const SizedBox(height: 9),
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
              const SizedBox(width: 9),
              Flexible(
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

  Widget _buildLessonAndTopic(
      HomeworkDetailData? detail,
      ) {
    return _buildResponsivePair(
      first: _buildLearningField(
        icon: Icons.auto_stories_outlined,
        label: 'Lesson',
        value: detail?.lesson?.name,
        color: Utils.getCardBorderColor(2),
      ),
      second: _buildLearningField(
        icon: Icons.lightbulb_outline_rounded,
        label: 'Topic',
        value: detail?.topic?.name,
        color: Utils.getCardBorderColor(4),
      ),
    );
  }

  Widget _buildLearningField({
    required IconData icon,
    required String label,
    required String? value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 19,
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          Utils.displayText(value),
          softWrap: true,
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDates(
      HomeworkDetailData? detail,
      ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stackDates =
            constraints.maxWidth < 280 ||
                MediaQuery.textScalerOf(context)
                    .scale(14) >
                    19;

        final startDate = _buildDateField(
          icon: Icons.calendar_month_outlined,
          label: 'Start date',
          value: detail?.startDate,
          color: Utils.getCardBorderColor(1),
        );

        final dueDate = _buildDateField(
          icon: Icons.event_outlined,
          label: 'Due date',
          value: detail?.dueDate,
          color: Utils.getCardBorderColor(3),
        );

        if (stackDates) {
          return Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
            children: [
              startDate,
              const SizedBox(height: 12),
              dueDate,
            ],
          );
        }

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
            children: [
              Expanded(child: startDate),
              VerticalDivider(
                width: 20,
                thickness: 1,
                color: AppColors.colorGrey1,
              ),
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
  }) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Container(
          width: 37,
          height: 37,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(
              alpha: 0.10,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
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
                Utils.formatDate(value),
                softWrap: true,
                style: TextStyle(
                  color: AppColors.ink,
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
        final stackFields =
            constraints.maxWidth < 280 ||
                MediaQuery.textScalerOf(context)
                    .scale(14) >
                    19;

        if (stackFields) {
          return Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
            children: [
              first,
              const SizedBox(height: 16),
              second,
            ],
          );
        }

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
            children: [
              Expanded(child: first),
              VerticalDivider(
                width: 20,
                thickness: 1,
                color: AppColors.colorGrey1,
              ),
              Expanded(child: second),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInstructions(
      HomeworkDetailData? detail,
      ) {
    return _buildSection(
      title: 'Instructions',
      icon: Icons.edit_note_rounded,
      borderColor:
      Utils.getCardBorderColor(4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          Utils.displayText(detail?.text),
          softWrap: true,
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 14,
            height: 1.65,
          ),
        ),
      ),
    );
  }

  Widget _buildVideoResource(
      BuildContext context,
      HomeworkDetailData? detail,
      ) {
    final youtubeUrl =
        detail?.youtubeUrl?.trim() ?? '';
    final videoUrl =
        detail?.videoUrl?.trim() ?? '';

    final hasYoutube =
    Utils.hasUrl(youtubeUrl);
    final hasVideo =
    Utils.hasUrl(videoUrl);

    if (!hasYoutube && !hasVideo) {
      return const SizedBox.shrink();
    }

    return _buildSection(
      title: 'Video resource',
      icon: Icons.smart_display_outlined,
      borderColor:
      Utils.getCardBorderColor(3),
      child: Column(
        children: [
          if (hasYoutube)
            _buildResourceRow(
              icon: Icons.smart_display_rounded,
              color: Utils.getCardBorderColor(3),
              title: 'Watch on YouTube',
              subtitle: youtubeUrl,
              action: 'Play',
              onTap: () =>
                  _openYoutubeVideo(youtubeUrl),
            ),
          if (hasYoutube && hasVideo)
            _buildDivider(),
          if (hasVideo)
            _buildResourceRow(
              icon:
              Icons.play_circle_outline_rounded,
              color: AppColors.purple,
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
    required Color borderColor,
    required Widget child,
  }) {
    return _buildCard(
      borderColor: borderColor,
      radius: 16,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            color: borderColor.withValues(
              alpha: 0.10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: borderColor,
                  size: 23,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildCard({
    required Color borderColor,
    required double radius,
    required Widget child,
  }) {
    return Material(
      color: AppColors.white,
      elevation: 2,
      shadowColor: AppColors.purple.withValues(
        alpha: 0.08,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: borderColor,
          width: 1.3,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
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
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.muted,
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
                horizontal: 12,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: color.withValues(
                  alpha: 0.10,
                ),
                borderRadius:
                BorderRadius.circular(20),
              ),
              child: Text(
                action,
                style: TextStyle(
                  color: color,
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
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Divider(
        height: 1,
        color: AppColors.colorGrey1,
      ),
    );
  }

  Future<void> _openYoutubeVideo(
      String url,
      ) async {
    final uri = Uri.tryParse(url.trim());

    if (uri == null ||
        !uri.hasAuthority ||
        (uri.scheme != 'https' &&
            uri.scheme != 'http')) {
      Utils.showToast(
        'Invalid video URL.',
        false,
      );
      return;
    }

    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened) {
        Utils.showToast(
          'Unable to open this video.',
          false,
        );
      }
    } catch (e) {
      Utils.showToast(
        'Unable to open this video.',
        false,
      );
      debugPrint(e.toString());
    }
  }
}
