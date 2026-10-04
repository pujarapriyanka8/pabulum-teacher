import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pabulum_teacher/bloc/login/login_bloc.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _isPasswordVisible = false;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _startAnimations();
  }

  void _startAnimations() {
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocBuilder<LoginBloc,LoginState>(
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                body: Container(
                  height: MediaQuery
                      .sizeOf(context)
                      .height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.icSplashBG1),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Welcome Section with Quote
                                FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 25),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.9,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.2,
                                              ),
                                              blurRadius: 15,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.school,
                                          size: 50,
                                          color: Color(0xFF2a5298),
                                        ),
                                      ),
                                      const SizedBox(height: 20),

                                      Text(
                                        'Welcome Back!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32,
                                          fontFamily: AppFonts.robotoBold,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.5,
                                              ),
                                              offset: const Offset(2, 2),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 40),

                                // Login Dialog
                                SlideTransition(
                                  position: _slideAnimation,
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 400,
                                    ),
                                    padding: const EdgeInsets.all(30),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.2,
                                          ),
                                          blurRadius: 25,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Login',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF2a5298),

                                            ),
                                          ),
                                          const SizedBox(height: 30),

                                          // Username Field
                                          TextFormField(
                                            controller: state.userName,
                                            decoration: InputDecoration(
                                              labelText: 'Username',
                                              prefixIcon: const Icon(
                                                Icons.person_outline,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFF2a5298),
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),

                                          // Password Field
                                          TextFormField(
                                            controller: state.password,
                                            obscureText: !_isPasswordVisible,
                                            decoration: InputDecoration(
                                              labelText: 'Password',
                                              prefixIcon: const Icon(
                                                Icons.lock_outline,
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isPasswordVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isPasswordVisible =
                                                    !_isPasswordVisible;
                                                  });
                                                },
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFF2a5298),
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 30),

                                          // Login Button
                                          ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                context.read<LoginBloc>().add(
                                                  OnLoginClickEvent(),
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFF2a5298,
                                              ),
                                              foregroundColor: Colors.white,
                                              padding:
                                              const EdgeInsets.symmetric(
                                                vertical: 16,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                              ),
                                              elevation: 5,
                                            ),
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                fontFamily:
                                                AppFonts.robotoRegular,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),

                                          // Forgot Password
                                          TextButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Forgot password feature coming soon!',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontFamily: AppFonts
                                                          .robotoRegular,
                                                    ),
                                                  ),
                                                  behavior:
                                                  SnackBarBehavior.floating,
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Forgot Password?',
                                              style: TextStyle(
                                                color: const Color(0xFF2a5298),
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                AppFonts.robotoRegular,
                                              ),
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
                        ),
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: Utils.navigationBar(),
              ),
              if (state.isLoading) Utils.loaderWid(),
              if (state.isLoading) Utils.loaderBrier(),
            ],
          );
        },
      ),
    );
  }
}
