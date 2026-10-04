import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pabulum_teacher/model/login_response.dart';
import 'package:pabulum_teacher/preferences/preferences.dart';
import 'package:pabulum_teacher/screen/main_navigation.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/constants.dart';
import 'package:pabulum_teacher/utils/utils.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    _startAnimations();


    _navigateToLogin();
  }

  void _startAnimations() {
    _fadeController.forward();
    _scaleController.forward();
  }

  void _navigateToLogin() {

    Future.delayed(const Duration(seconds: 1), () async {
      if (mounted) {
        var isLogin = await Preference.getBoolean(Constants.isLogin);
        print(isLogin);
        if(isLogin){
          final userData =await Preference.getString(Constants.loginUserData);
          Constants.shared.userLoginData =
              UserData.fromJson(jsonDecode(userData));
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
              const MainNavigation(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 800),
            ),
          );
        }else{
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginScreen(),
            ),
          );
        }


      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.icSplashBG),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),

          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Image.asset(
                            AppImages.icSplashLogo,
                            height: 200,
                            width: 250,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Pabulum',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,

                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Student Learning Platform',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                              letterSpacing: 1,
                            ),
                          ),

                          SizedBox(height: 50,)
                        ],
                      ),
                    ),
                  ),
                  Utils.navigationBar(color: AppColors.white),

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
