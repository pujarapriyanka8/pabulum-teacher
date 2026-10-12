
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pabulum_teacher/model/login_response.dart';
import 'package:pabulum_teacher/preferences/preferences.dart';
import 'package:pabulum_teacher/screen/login_screen.dart';
import 'package:pabulum_teacher/screen/main_navigation.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late AnimationController _floatingController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entryController,
      curve: const Interval(
        0.0,
        0.75,
        curve: Curves.easeOut,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.82,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: Curves.easeOutBack,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: Curves.easeOutCubic,
      ),
    );

    _entryController.forward();
    _floatingController.repeat();

    _navigateToLogin();
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;

      var isLogin = await Preference.getBoolean(Constants.isLogin);

      if (isLogin) {
        final userData =
        await Preference.getString(Constants.loginUserData);

        Constants.shared.userLoginData =
            UserData.fromJson(jsonDecode(userData));

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (
                context,
                animation,
                secondaryAnimation,
                ) =>
            const MainNavigation(),
            transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
                ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration:
            const Duration(milliseconds: 600),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (
                context,
                animation,
                secondaryAnimation,
                ) =>
            const LoginScreen(),
            transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
                ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration:
            const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppImages.icBackground,
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final height = constraints.maxHeight;

                  final scale = math.min(
                    width / 390,
                    height / 820,
                  ).clamp(0.72, 1.15).toDouble();

                  final logoWidth = math.min(
                    width * 0.58,
                    245 * scale,
                  );

                  final illustrationWidth = math.min(
                    width * 0.94,
                    height * 0.45,
                  );

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: height * 0.075,
                        left: 0,
                        right: 0,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Center(
                            child: Image.asset(
                              AppImages.icSplashLogo,
                              width: logoWidth,
                              height: height * 0.11,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: height * 0.225,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: AnimatedBuilder(
                              animation: _floatingController,
                              builder: (context, child) {
                                final y = math.sin(
                                  _floatingController.value *
                                      math.pi *
                                      2,
                                ) *
                                    4;

                                return Transform.translate(
                                  offset: Offset(0, y),
                                  child: child,
                                );
                              },
                              child: Image.asset(
                                AppImages.bookWorldLogo,
                                width: illustrationWidth,
                                height: height * 0.36,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: height * 0.605,
                        left: 0,
                        right: 0,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Text(
                              'Pabulum',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 54 * scale,
                                height: 1.1,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textPrimary,
                                letterSpacing: -1.8,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: height * 0.705,
                        left: 12,
                        right: 12,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (bounds) {
                                return const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF7C4DFF),
                                    Color(0xFFAF40DB),
                                    Color(0xFFEA3A86),
                                  ],
                                ).createShader(bounds);
                              },
                              child: Text(
                                'A little curiosity.\n'
                                    'A world to discover.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 23 * scale,
                                  height: 1.3,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: height * 0.83,
                        left: 0,
                        right: 0,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: _buildTagline(scale),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagline(double scale) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Learn',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14 * scale,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 10 * scale),
        _dot(AppColors.blue, scale),
        SizedBox(width: 10 * scale),
        Text(
          'Connect',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14 * scale,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 10 * scale),
        _dot(AppColors.orange, scale),
        SizedBox(width: 10 * scale),
        Text(
          'Grow',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14 * scale,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _dot(Color color, double scale) {
    return Container(
      width: 7 * scale,
      height: 7 * scale,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
