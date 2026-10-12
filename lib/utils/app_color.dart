import 'package:flutter/material.dart';


class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color primary = Color(0xFF7C4DFF);
  static const Color primaryDark = Color(0xFF6536E8);
  static const Color primaryLight = Color(0xFF9C78FF);

  static const Color gradientStart = Color(0xFF7047F5);
  static const Color gradientEnd = Color(0xFF9A3CFF);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      gradientStart,
      gradientEnd,
    ],
  );

  static const Color textPrimary = Color(0xFF17213D);
  static const Color textSecondary = Color(0xFF747C92);
  static const Color textHint = Color(0xFF9BA2B5);
  static const Color textLight = Color(0xFFB4BAC9);

  static const Color background = Color(0xFFF9F8FE);
  static const Color backgroundLavender = Color(0xFFF6F3FF);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFFCFBFF);

  static const Color border = Color(0xFFE8E3F3);
  static const Color inputBorder = Color(0xFFE0DAEC);
  static const Color divider = Color(0xFFECE8F3);

  static const Color lavender = Color(0xFFF0E9FF);
  static const Color lavenderLight = Color(0xFFF7F3FF);
  static const Color lavenderMedium = Color(0xFFE7DAFF);

  static const Color softBlue = Color(0xFFE6F2FF);
  static const Color blueLight = Color(0xFFF2F8FF);
  static const Color blue = Color(0xFF3C9CEB);

  static const Color mint = Color(0xFFDFF7EE);
  static const Color mintLight = Color(0xFFF0FBF7);

  static const Color green = Color(0xFF08A678);
  static const Color greenDark = Color(0xFF068A64);

  static const Color pink = Color(0xFFE94C82);
  static const Color softPink = Color(0xFFFFE7EF);
  static const Color pinkLight = Color(0xFFFFF3F7);

  static const Color red = Color(0xFFEF476F);
  static const Color redLight = Color(0xFFFFE7ED);

  static const Color orange = Color(0xFFF2994A);
  static const Color orangeLight = Color(0xFFFFEBDD);

  static const Color peach = Color(0xFFFFEADB);
  static const Color peachLight = Color(0xFFFFF5EE);

  static const Color yellow = Color(0xFFF4B63F);
  static const Color softYellow = Color(0xFFFFF3CB);

  static const Color cardPurple = Color(0xFFF7F2FF);
  static const Color cardBlue = Color(0xFFF1F8FF);
  static const Color cardMint = Color(0xFFF1FBF7);
  static const Color cardPeach = Color(0xFFFFF6EF);
  static const Color cardPink = Color(0xFFFFF4F7);

  static const Color iconPurpleBg = Color(0xFFF0E8FF);
  static const Color iconBlueBg = Color(0xFFE9F4FF);
  static const Color iconGreenBg = Color(0xFFE5F8F1);
  static const Color iconPinkBg = Color(0xFFFFEAF1);
  static const Color iconPeachBg = Color(0xFFFFEEE1);

  static const Color success = green;
  static const Color successBg = mint;

  static const Color error = red;
  static const Color errorBg = redLight;

  static const Color warning = orange;
  static const Color warningBg = orangeLight;

  static const Color shadow = Color(0x140F173A);
  static const Color purpleShadow = Color(0x1A7C4DFF);

  static const Color disabledBackground = Color(0xFFF1F1F5);
  static const Color disabledText = Color(0xFF9DA4B4);

  static const Color transparent = Colors.transparent;


//remove
  static Color colorBlack = const Color(0xFF000000);
  static Color colorLiteBlack = const Color(0xFF333333);

  // Primary theme colour.
  // Existing names retained so current references still work.
  static Color colorPrimaryBlue = const Color(0xFF7047EB);
  static Color colorPrimary500 = const Color(0xFF7047EB);
  static Color purple = const Color(0xFF7047EB);
  static Color colorPurple = const Color(0xFF7047EB);

  // Accent colours.
  static Color colorPrimaryOrange = const Color(0xFFF2AB42);
  static Color colorPrimaryRed = const Color(0xFFD63862);

  // Text colours.
  static Color ink = const Color(0xFF20233F);
  static Color navy = const Color(0xFF20233F);

  static Color muted = const Color(0xFF74658F);
  static Color colorMuted = const Color(0xFF74658F);
  static Color colorNeutral700 = const Color(0xFF74658F);
  static Color colorGrey = const Color(0xFF74658F);
  static Color colorGreyDark = const Color(0xFF65558F);


  static Color colorInputBorderColor = const Color(0xFFD8C8F5);
  static Color colorGrey1 = const Color(0xFFE9E3F3);
  static Color baseColorWhite85 = const Color(0xFFE9E3F3);
  static Color baseColorWhite45 = const Color(0xFF9585B2);

  // Success and error colours.
  static Color colorGreenLight700 = const Color(0xFFE2F6ED);

  static Color colorError500 = const Color(0xFFBA1A1A);
  static Color colorRedError = const Color(0xFFBA1A1A);



  static const Color attendanceNavy = Color(0xFF062B69);
  static const Color attendanceBlue = Color(0xFF0876D1);
  static const Color attendanceSkyBlue = Color(0xFFE5F4FF);

  static const Color attendanceOrange = Color(0xFFFFB301);
  static const Color attendanceYellow = Color(0xFFFFD152);

  static const Color attendanceGreen = Color(0xFF059467);
  static const Color attendanceGreenBg = Color(0xFFE8FAF1);

  static const Color attendanceRed = Color(0xFFD62858);
  static const Color attendanceRedBg = Color(0xFFFFEDF2);

  static const Color screenBackground = Color(0xFFF7FAFF);
}

class AppFonts {
  static const String robotoRegular = 'RobotoRegular';
  static const String robotoMedium = 'RobotoMedium';
  static const String robotoBold = 'RobotoBold';
}
