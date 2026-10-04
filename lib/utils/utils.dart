import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pabulum_teacher/model/classwork_detail_model.dart';
import 'package:pabulum_teacher/screen/media_screen.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils{

  static Text noDataFound (String? message){
    return Text(message??'No data found',style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500
    ),);
  }
  static Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255, // full opacity
      random.nextInt(256), // red
      random.nextInt(256), // green
      random.nextInt(256), // blue
    );
  }

  static String formatAttendanceDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  static PreferredSizeWidget customAppBar(String? title,BuildContext context,{required bool isBack,required VoidCallback onBackPress }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        leading:isBack ? IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            onBackPress();
          },
        ) : const SizedBox() ,
        title: Text(
          title ?? '',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D3748),
          ),        ),
       /* actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
              },
              child: const Icon(Icons.no_accounts,
                  color: Colors.white, size: 30),
            ),
          ),
        ],*/
      ),
    );
  }
  static void showToast(message, isSuccess, {int second = 5}) {
    showToastWidget(
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSuccess ? AppColors.colorPrimaryBlue : AppColors.colorError500,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(message,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
        ),
        duration: Duration(seconds: second),
        position: ToastPosition.top);
  }
  static OutlineInputBorder inputBorder(color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    );
  }
  static Opacity loaderBrier() => Opacity(
    opacity: 0.8,
    child: ModalBarrier(
        dismissible: false, color: Colors.black.withOpacity(0.4)),
  );

  static Center loaderWid({double? radius = 16.0}) => Center(
    child: CupertinoActivityIndicator(
      radius: radius ?? 16.0,
      color: AppColors.colorPrimaryBlue,
    ),
  );


  static Color getSubjectColor(String subjectName) {
    final lowerName = subjectName.toLowerCase();
    if (lowerName.contains('math') || lowerName.contains('ગણિત')) {
      return const Color(0xFF4CAF50);
    } else if (lowerName.contains('science') || lowerName.contains('વિજ્ઞાન')) {
      return const Color(0xFF2196F3);
    } else if (lowerName.contains('english') || lowerName.contains('અંગ્રેજી')) {
      return const Color(0xFFFF9800);
    } else if (lowerName.contains('history') || lowerName.contains('ઇતિહાસ')) {
      return const Color(0xFF9C27B0);
    } else if (lowerName.contains('gujarati') || lowerName.contains('ગુજરાતી')) {
      return const Color(0xFFE91E63);
    } else if (lowerName.contains('hindi') || lowerName.contains('હિન્દી')) {
      return const Color(0xFFFF5722);
    } else {
      return const Color(0xFF607D8B);
    }
  }
  static String parseDateToFormate(
      String date,
      String format,
      String apiDateFormat,
      ) {
    if (date.isEmpty) return '';

    try {
      DateTime dateTime = DateFormat(apiDateFormat).parse(date);
      return DateFormat(format).format(dateTime);
    } catch (e) {
      return '';
    }
  }
  static IconData getSubjectIcon(String subjectName) {
    final lowerName = subjectName.toLowerCase();
    if (lowerName.contains('math') || lowerName.contains('ગણિત')) {
      return Icons.calculate_rounded;
    } else if (lowerName.contains('science') || lowerName.contains('વિજ્ઞાન')) {
      return Icons.science_rounded;
    } else if (lowerName.contains('english') || lowerName.contains('અંગ્રેજી')) {
      return Icons.book_rounded;
    } else if (lowerName.contains('history') || lowerName.contains('ઇતિહાસ')) {
      return Icons.history_edu_rounded;
    } else if (lowerName.contains('gujarati') || lowerName.contains('ગુજરાતી')) {
      return Icons.language_rounded;
    } else if (lowerName.contains('hindi') || lowerName.contains('હિન્દી')) {
      return Icons.translate_rounded;
    } else {
      return Icons.menu_book_rounded;
    }
  }
  static Widget navigationBar({Color? color}) {
    return Container(
      height: 44,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(
            Icons.copyright,
            size: 16,
            color: AppColors.colorPrimaryBlue,
          ),
          const SizedBox(width: 5),
          Text(
            'Manovikas Mulyankan Sanstha 2025',
            style: TextStyle(
              color: color ?? Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static String formatTime(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }


  static Future<void> open(
      BuildContext context, {
        required ClassworkMediaType type,
        required String url,
      }) async {
    final value = url.trim();
    final uri = Uri.tryParse(value);

    if (uri == null ||
        uri.host.isEmpty ||
        (uri.scheme != 'https' && uri.scheme != 'http')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid attachment URL.'),
        ),
      );
      return;
    }

    if (type == ClassworkMediaType.audio) {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(26),
          ),
        ),
        builder: (_) => AudioSheet(url: value),
      );
      return;
    }

    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => MediaScreen(
          type: type,
          url: value,
        ),
      ),
    );
  }

  static String displayText(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? '—' : text;
  }

  static bool hasUrl(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  static String formatDate(String? value) {
    if (value == null || value.trim().isEmpty) return '—';

    try {
      final date = DateFormat('dd-MM-yyyy').parseStrict(value.trim());
      return DateFormat('dd MMM yyyy').format(date);
    } catch (_) {
      return value;
    }
  }

  static String text(Object? value, {String fallback = '—'}) {
    final result = value?.toString().trim() ?? '';
    return result.isEmpty || result == 'null' ? fallback : result;
  }

  static DateTime? parseDate(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty || input == '-') return null;

    for (final pattern in [
      'dd-MM-yyyy',
      'yyyy-MM-dd',
      'dd/MM/yyyy',
    ]) {
      try {
        return DateFormat(pattern).parseStrict(input);
      } catch (_) {
        // Try the next supported format.
      }
    }

    return DateTime.tryParse(input)?.toLocal();
  }

  static bool isToday(String? value) {
    final date = parseDate(value);
    if (date == null) return false;

    final now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static String dateLabel(String? value) {
    final date = parseDate(value);
    return date == null
        ? text(value)
        : DateFormat('dd MMM yyyy').format(date);
  }

  static String period(String? start, String? end) {
    return '${dateLabel(start)} – ${dateLabel(end)}';
  }

  static bool isPast(String? endDate) {
    final end = parseDate(endDate);
    if (end == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final endDay = DateTime(end.year, end.month, end.day);

    return endDay.isBefore(today);
  }

  static String classLabel({
    required String? standard,
    required String? division,
  }) {
    return '${displayText(standard)} • ${displayText(division)}';
  }

  static bool hasVideo({
    required String? youtubeUrl,
    required String? videoUrl,
  }) {
    return hasUrl(youtubeUrl) || hasUrl(videoUrl);
  }

  static int attachmentCount(Iterable<String?> urls) {
    return urls.where(hasUrl).length;
  }

  static String durationText(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = (duration.inSeconds % 60)
        .toString()
        .padLeft(2, '0');

    return '$minutes:$seconds';
  }

  static Future<void> openUrl({required String link}) async {
    final Uri url = Uri.parse(link);

    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> openPDF(String url) async {
    final uri = Uri.tryParse(url.trim());

    if (uri == null ||
        uri.host.isEmpty ||
        (uri.scheme != 'https' && uri.scheme != 'http')) {
      Utils.showToast('Invalid PDF URL.', false);
      return;
    }

    for (final mode in [
      LaunchMode.externalApplication,
      LaunchMode.platformDefault,
    ]) {
      try {
        final launched = await launchUrl(
          uri,
          mode: mode,
        );

        if (launched) return;
      } catch (e) {
        debugPrint('Opening PDF failed: $e');
      }
    }

    Utils.showToast(
      'Unable to open the PDF link. Please try again.',
      false,
    );
  }
}


extension EmptySpace on num {
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());
}