import 'package:flutter/material.dart';

import 'package:pabulum_teacher/utils/constants.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class AttachmentsSection extends StatelessWidget {
  const AttachmentsSection({
    super.key,
    this.imageUrls = const [],
    this.pdfUrl,
    this.audioUrl,
    this.title = 'Attachments',
    this.pdfTitle = 'Document attachment',
    this.audioTitle = 'Audio attachment',
  });

  final List<String?> imageUrls;
  final String? pdfUrl;
  final String? audioUrl;

  final String title;
  final String pdfTitle;
  final String audioTitle;

  static const _navy = Color(0xFF192841);
  static const _purple = Color(0xFF7051CC);
  static const _muted = Color(0xFF7B8498);

  @override
  Widget build(BuildContext context) {
    final images = imageUrls
        .where(Utils.hasUrl)
        .map((url) => url!.trim())
        .toList();

    final pdf = pdfUrl?.trim() ?? '';
    final audio = audioUrl?.trim() ?? '';

    final hasPdf = Utils.hasUrl(pdf);
    final hasAudio = Utils.hasUrl(audio);

    final count = Utils.attachmentCount([
      ...images,
      pdf,
      audio,
    ]);

    final items = <Widget>[
      for (int index = 0; index < images.length; index++)
        _buildItem(
          leading: _buildThumbnail(images[index]),
          title: images.length == 1
              ? 'Image attachment'
              : 'Image attachment ${index + 1}',
          subtitle: 'Tap to preview',
          action: 'View',
          onTap: () => Utils.open(
            context,
            type: ClassworkMediaType.image,
            url: images[index],
          ),
        ),
      if (hasPdf)
        _buildItem(
          leading: _buildIcon(
            icon: Icons.picture_as_pdf_outlined,
            color: const Color(0xFFD94E65),
            background: const Color(0xFFFFEDF1),
          ),
          title: pdfTitle,
          action: 'Open',
          actionIcon: Icons.open_in_new_rounded,
          onTap: () => Utils.openPDF(pdf),
        ),
      if (hasAudio)
        _buildItem(
          leading: _buildIcon(
            icon: Icons.music_note_rounded,
            color: const Color(0xFF178564),
            background: const Color(0xFFE5F5ED),
          ),
          title: audioTitle,
          action: 'Play',
          actionIcon: Icons.play_arrow_rounded,
          onTap: () => Utils.open(
            context,
            type: ClassworkMediaType.audio,
            url: audio,
          ),
        ),
    ];

    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: const Color(0x167051CC),
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(count),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'No attachments',
                style: TextStyle(
                  color: _muted,
                  fontSize: 13,
                ),
              ),
            )
          else
            for (int index = 0; index < items.length; index++) ...[
              if (index > 0) _buildDivider(),
              items[index],
            ],
        ],
      ),
    );
  }

  Widget _buildHeader(int count) {
    return Container(
      color: const Color(0xFFDFF3E9),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.attach_file_rounded,
            color: Color(0xFF178564),
            size: 22,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: _navy,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
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
              '$count ${count == 1 ? 'file' : 'files'}',
              style: const TextStyle(
                color: _navy,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 82,
        height: 70,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          excludeFromSemantics: true,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;

            return const ColoredBox(
              color: Color(0xFFF0EBFC),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: _purple,
                  ),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const ColoredBox(
              color: Color(0xFFF0EBFC),
              child: Icon(
                Icons.image_not_supported_outlined,
                color: _purple,
                size: 27,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIcon({
    required IconData icon,
    required Color color,
    required Color background,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: color,
        size: 27,
      ),
    );
  }

  Widget _buildItem({
    required Widget leading,
    required String title,
    required String action,
    required VoidCallback onTap,
    String? subtitle,
    IconData? actionIcon,
  }) {
    return Semantics(
      button: true,
      label: '$action $title',
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final stackAction = constraints.maxWidth < 300 ||
                  MediaQuery.textScalerOf(context).scale(14) > 19;

              final text = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    softWrap: true,
                    style: const TextStyle(
                      color: _navy,
                      fontSize: 14,
                      height: 1.4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      softWrap: true,
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              );

              final actionBadge = _buildAction(
                label: action,
                icon: actionIcon,
              );

              // Extra-small layouts keep the content readable.
              if (constraints.maxWidth < 220) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    leading,
                    const SizedBox(height: 10),
                    text,
                    const SizedBox(height: 9),
                    actionBadge,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leading,
                  const SizedBox(width: 12),
                  Expanded(
                    child: stackAction
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text,
                        const SizedBox(height: 9),
                        actionBadge,
                      ],
                    )
                        : text,
                  ),
                  if (!stackAction) ...[
                    const SizedBox(width: 10),
                    actionBadge,
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAction({
    required String label,
    IconData? icon,
  }) {
    final isPlay = icon == Icons.play_arrow_rounded;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EBFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Wrap(
        spacing: 5,
        runSpacing: 4,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (isPlay)
            Icon(
              icon,
              color: _purple,
              size: 19,
            ),
          Text(
            label,
            style: const TextStyle(
              color: _purple,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (icon != null && !isPlay)
            Icon(
              icon,
              color: _purple,
              size: 15,
            ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFECE8F5),
      ),
    );
  }
}