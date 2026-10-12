
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:pabulum_teacher/bloc/classwork/classwork_bloc.dart';
import 'package:pabulum_teacher/model/classwork_detail_model.dart';
import 'package:pabulum_teacher/screen/attachment_section.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/constants.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class ClassworkDetailScreen extends StatelessWidget {
  const ClassworkDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final classworkId =
    ModalRoute.of(context)!.settings.arguments as num;

    return BlocProvider(
      create: (_) => ClassworkBloc()
        ..add(
          ClassworkEvent.onLoadClassworkDetail(
            classworkId: classworkId.toString(),
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: CustomAppBar(
                          title: 'Classwork Details',
                          subtitle:
                          'Explore classwork details\nand learning resources.',
                          image: AppImages.icClassworkHeader,
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<
                            ClassworkBloc,
                            ClassworkState>(
                          builder: (context, state) {
                            final detail =
                                state.classworkDetailData;

                            if (state.isLoading) {
                              return Center(
                                child:
                                CircularProgressIndicator(
                                  color: AppColors.purple,
                                ),
                              );
                            }

                            return ListView(
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
                                _buildContent(detail),
                                if (Utils.hasVideo(
                                  youtubeUrl:
                                  detail?.youtubeUrl ?? '',
                                  videoUrl:
                                  detail?.videoUrl ?? '',
                                )) ...[
                                  const SizedBox(height: 16),
                                  _buildVideoResource(
                                    context,
                                    detail,
                                  ),
                                ],
                                const SizedBox(height: 16),
                                AttachmentsSection(
                                  imageUrls: [
                                    detail?.imageUrl,
                                  ],
                                  pdfUrl: detail?.pdfUrl,
                                  audioUrl: detail?.audioUrl,
                                  pdfTitle:
                                  'Classwork document',
                                ),
                                const SizedBox(height: 12),
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
      ClassworkDetailData? detail,
      ) {
    final borderColor =
    Utils.getCardBorderColor(0);

    return Material(
      color: AppColors.white,
      elevation: 2,
      shadowColor:
      AppColors.purple.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: borderColor,
          width: 1.3,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            color: borderColor.withValues(alpha: 0.13),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  color: borderColor,
                  size: 25,
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: Text(
                    Utils.displayText(
                      detail?.subject?.name,
                    ),
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: Text(
                        Utils.classLabel(
                          standard:
                          detail?.standard?.name,
                          division:
                          detail?.division?.name,
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: borderColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        Utils.displayText(
                          detail?.title,
                        ),
                        softWrap: true,
                        style: TextStyle(
                          color: AppColors.ink,
                          fontSize: 20,
                          height: 1.3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: borderColor.withValues(
                          alpha: 0.10,
                        ),
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: borderColor,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            Utils.formatDate(
                              detail?.date,
                            ),
                            style: TextStyle(
                              color: borderColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _buildLearningField(
                          icon:
                          Icons.auto_stories_outlined,
                          label: 'Lesson',
                          value: detail?.lesson?.name,
                        ),
                      ),
                      VerticalDivider(
                        width: 25,
                        thickness: 1,
                        color: AppColors.colorGrey1,
                      ),
                      Expanded(
                        child: _buildLearningField(
                          icon: Icons.sell_outlined,
                          label: 'Topic',
                          value: detail?.topic?.name,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningField({
    required IconData icon,
    required String label,
    required String? value,
  }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: AppColors.purple,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Text(
          Utils.displayText(value),
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

  Widget _buildContent(
      ClassworkDetailData? detail,
      ) {
    return _buildSection(
      title: 'Classwork content',
      icon: Icons.description_outlined,
      borderColor: Utils.getCardBorderColor(2),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          Utils.displayText(detail?.text),
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 14,
            height: 1.6,
          ),
        ),
      ),
    );
  }

  Widget _buildVideoResource(
      BuildContext context,
      ClassworkDetailData? detail,
      ) {
    final youtubeUrl =
        detail?.youtubeUrl?.trim() ?? '';
    final videoUrl =
        detail?.videoUrl?.trim() ?? '';

    final hasYoutube = Utils.hasUrl(youtubeUrl);
    final hasVideo = Utils.hasUrl(videoUrl);

    if (!hasYoutube && !hasVideo) {
      return const SizedBox.shrink();
    }

    return _buildSection(
      title: 'Video resource',
      icon: Icons.smart_display_outlined,
      borderColor: Utils.getCardBorderColor(3),
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
              title: 'Classwork video',
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
    return Material(
      color: AppColors.white,
      elevation: 2,
      shadowColor:
      AppColors.purple.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: borderColor,
          width: 1.3,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: [
          Container(
            color: borderColor.withValues(alpha: 0.10),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: borderColor,
                  size: 22,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 14,
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
                horizontal: 14,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
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
      const EdgeInsets.symmetric(horizontal: 14),
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
