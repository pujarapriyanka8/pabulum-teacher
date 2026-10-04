import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pabulum_teacher/bloc/classwork/classwork_bloc.dart';

import 'package:pabulum_teacher/model/classwork_detail_model.dart';
import 'package:pabulum_teacher/screen/attachment_section.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/constants.dart';
import 'package:pabulum_teacher/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ClassworkDetailScreen extends StatelessWidget {
  const ClassworkDetailScreen({
    super.key,
  });




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
        backgroundColor: const Color(0xFFF6F7FC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.navy,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Classwork Details',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: BlocBuilder<ClassworkBloc, ClassworkState>(
            builder: (context, state) {
              final detail = state.classworkDetailData;

              if (state.isLoading) {
                return  Center(
                  child: CircularProgressIndicator(color: AppColors.colorPurple),
                );
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildOverview(detail),
                  const SizedBox(height: 16),
                  _buildContent(detail),
                  if (Utils.hasVideo(youtubeUrl:  detail?.youtubeUrl??'', videoUrl: detail?.videoUrl??'')) ...[
                    const SizedBox(height: 16),
                    _buildVideoResource(context, detail),
                  ],
                  const SizedBox(height: 16),
                  // _buildYoutubeResourceSection(
                  //   detail?.youtubeUrl,
                  // ),
                  const SizedBox(height: 16),
                  AttachmentsSection(
                    imageUrls: [detail?.imageUrl],
                    pdfUrl: detail?.pdfUrl,
                    audioUrl: detail?.audioUrl,
                    pdfTitle: 'Classwork document',
                  ),
                  const SizedBox(height: 12),
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
      ClassworkDetailData? detail,
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


  Widget _buildOverview(ClassworkDetailData? detail) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: const Color(0x167051CC),
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header touches the top and sides of the card.
          Container(
            width: double.infinity,
            color: const Color(0xFFE8E0FC),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFF7051CC),
                  size: 25,
                ),
                const SizedBox(width: 10),

                Expanded(
                  flex: 3,
                  child: Text(
                    Utils.displayText(detail?.subject?.name),
                    style: const TextStyle(
                      color: Color(0xFF192841),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F2FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        Utils.classLabel(standard: detail?.standard?.name, division: detail?.division?.name,),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF192841),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        Utils.displayText(detail?.title),
                        softWrap: true,
                        style: const TextStyle(
                          color: Color(0xFF192841),
                          fontSize: 20,
                          height: 1.3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0EBFC),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xFF7051CC),
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            Utils.formatDate(detail?.date),
                            style: const TextStyle(
                              color: Color(0xFF7051CC),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _buildLearningField(
                          icon: Icons.auto_stories_outlined,
                          label: 'Lesson',
                          value: detail?.lesson?.name,
                        ),
                      ),
                      const VerticalDivider(
                        width: 25,
                        thickness: 1,
                        color: Color(0xFFEAE7F2),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: AppColors.colorPurple),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style:  TextStyle(color: AppColors.colorMuted, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        Text(
          Utils.displayText(value),
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

  Widget _buildContent(ClassworkDetailData? detail) {
    return _buildSection(
      title: 'Classwork content',
      icon: Icons.description_outlined,
      headerColor: const Color(0xFFEDE7FC),
      iconColor: AppColors.colorPurple,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          Utils.displayText(detail?.text),
          style:  TextStyle(
            color: AppColors.navy,
            fontSize: 14,
            height: 1.6,
          ),
        ),
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