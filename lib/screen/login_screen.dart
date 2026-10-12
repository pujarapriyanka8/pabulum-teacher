
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
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final keyboardVisible =
              MediaQuery.viewInsetsOf(context).bottom > 0;

          return Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.background,
                resizeToAvoidBottomInset: true,
                bottomNavigationBar: Utils.navigationBar(),
                body: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        AppImages.icBackgroundAll,
                        fit: BoxFit.fill,
                      ),

                      SafeArea(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final height = constraints.maxHeight;
                            final compact = height < 690;

                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                SingleChildScrollView(
                                  keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior
                                      .onDrag,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: height,
                                    ),
                                    child: Center(
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          maxWidth: 430,
                                        ),
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                            children: [
                                              SizedBox(
                                                height: compact ? 12 : 25,
                                              ),

                                              _buildFrolicLogo(),

                                              SizedBox(
                                                height: compact ? 4 : 10,
                                              ),

                                              _buildBoyIllustration(
                                                compact
                                                    ? 180
                                                    : (height * 0.27)
                                                    .clamp(
                                                  180.0,
                                                  230.0,
                                                ),
                                              ),

                                              const SizedBox(height: 9),

                                              _buildWelcomeSection(),

                                              SizedBox(
                                                height: compact ? 22 : 28,
                                              ),

                                              _buildUsernameField(state),

                                              const SizedBox(height: 15),

                                              _buildPasswordField(state),

                                              _buildForgotPassword(context),

                                              const SizedBox(height: 13),

                                              _buildLoginButton(context),

                                              SizedBox(
                                                height: keyboardVisible
                                                    ? 30
                                                    : 135,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
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
              ),

              if (state.isLoading) Utils.loaderWid(),
              if (state.isLoading) Utils.loaderBrier(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFrolicLogo() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: Image.asset(
          AppImages.icSplashLogo,
          width: 210,
          height: 92,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildBoyIllustration(double height) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Image.asset(
            AppImages.icLoginHeader,
            height: height,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            const Text(
              'Welcome back! 👋',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                height: 1.15,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ready for a wonderful school day?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary.withValues(alpha: 0.55),
                fontSize: 14.5,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField(LoginState state) {
    return TextFormField(
      controller: state.userName,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      cursorColor: AppColors.primary,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter username';
        }
        return null;
      },
      decoration: _inputDecoration(
        hint: 'Enter your username',
        icon: Icons.person_outline_rounded,
      ),
    );
  }

  Widget _buildPasswordField(LoginState state) {
    return TextFormField(
      controller: state.password,
      obscureText: !_isPasswordVisible,
      textInputAction: TextInputAction.done,
      cursorColor: AppColors.primary,
      onFieldSubmitted: (_) {
        _login(context);
      },
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
      decoration: _inputDecoration(
        hint: 'Enter your password',
        icon: Icons.lock_outline_rounded,
      ).copyWith(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          icon: Icon(
            _isPasswordVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppColors.textPrimary,
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text(
                  'Forgot password feature coming soon!',
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
        },
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 5,
            right: 2,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: const Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.primary,
            AppColors.primary.withValues(alpha: 0.85),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.20),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            _login(context);
          },
          child: const Center(
            child: Text(
              'Login',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: AppColors.textPrimary.withValues(alpha: 0.43),
        fontSize: 14.5,
      ),
      prefixIcon: Icon(
        icon,
        color: AppColors.textPrimary,
        size: 24,
      ),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 60,
      ),
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      border: _fieldBorder(AppColors.lavenderMedium),
      enabledBorder: _fieldBorder(AppColors.lavenderMedium),
      focusedBorder: _fieldBorder(
        AppColors.primary,
        width: 1.7,
      ),
      errorBorder: _fieldBorder(Colors.redAccent),
      focusedErrorBorder: _fieldBorder(
        Colors.redAccent,
        width: 1.7,
      ),
    );
  }

  OutlineInputBorder _fieldBorder(
      Color color, {
        double width = 1,
      }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  void _login(BuildContext context) {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
        OnLoginClickEvent(),
      );
    }
  }
}
