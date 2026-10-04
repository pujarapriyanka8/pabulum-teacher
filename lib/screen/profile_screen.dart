import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pabulum_teacher/bloc/login/login_bloc.dart';
import 'package:pabulum_teacher/component/common_alert_dialog.dart';
import 'package:pabulum_teacher/model/profile_model.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color _background = Color(0xFFF5F1E9);
  static const Color _green = Color(0xFF174C43);
  static const Color _sage = Color(0xFFDDE2D0);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc()..add(OnLoadProfileEvent()),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: _background,
                appBar: Utils.customAppBar(
                  'Profile',
                  context,
                  isBack: false,
                  onBackPress: () {},
                ),
                body: SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          20,
                          20,
                          16,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight > 36
                                ? constraints.maxHeight - 36
                                : 0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 28),
                                  _buildTeacherProfile(state.profileData),
                                  const SizedBox(height: 22),
                                  _buildSchool(state.profileData),
                                  const SizedBox(height: 30),
                                  const Text(
                                    'Helpful information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: _green,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  _buildMenu(context),
                                  const SizedBox(height: 18),
                                  _buildLogout(context),
                                ],
                              ),
                             // _buildBooksDecoration(),
                              const SizedBox(height: 18),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                bottomNavigationBar: Utils.navigationBar(),
              ),
              if (state.isLoading) Utils.loaderBrier(),
              if (state.isLoading) Utils.loaderWid(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        _buildPencilDecoration(),
      ],
    );
  }

  Widget _buildTeacherProfile(ProfileData? profileData) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileImage(
          name: profileData?.name ?? '',
          imageUrl: profileData?.profileImage ?? '',
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (profileData?.role ?? '').toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFF537366),
                  fontSize: 10,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                profileData?.name ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: _green,
                ),
              ),
              if (profileData?.email?.isNotEmpty == true) ...[
                const SizedBox(height: 7),
                Text(
                  profileData?.email ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF666864),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage({
    required String name,
    required String imageUrl,
  }) {
    return ClipOval(
      child: SizedBox(
        width: 70,
        height: 70,
        child: imageUrl.isEmpty
            ? _buildInitials(name)
            : Image.network(
          imageUrl,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) {
              return child;
            }

            return _buildInitials(name);
          },
          errorBuilder: (context, error, stackTrace) {
            return _buildInitials(name);
          },
        ),
      ),
    );
  }

  Widget _buildInitials(String name) {
    final words = name
        .trim()
        .split(RegExp(r'[\s_-]+'))
        .where((word) => word.isNotEmpty)
        .toList();

    final initials = words.isEmpty
        ? 'T'
        : words
        .take(2)
        .map((word) => word.characters.first)
        .join()
        .toUpperCase();

    return Container(
      alignment: Alignment.center,
      color: const Color(0xFFD6DDC5),
      child: Text(
        initials,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: _green,
        ),
      ),
    );
  }

  Widget _buildSchool(ProfileData? profileData) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: _sage,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 44,
              height: 44,
              child: profileData?.school?.profileImage?.isEmpty == true
                  ? _buildSchoolIcon()
                  : Image.network(
                profileData?.school?.profileImage ?? '',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  return progress == null ? child : _buildSchoolIcon();
                },
                errorBuilder: (context, error, stackTrace) {
                  return _buildSchoolIcon();
                },
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MY SCHOOL',
                  style: TextStyle(
                    color: Color(0xFF537366),
                    fontSize: 10,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  profileData?.school?.name ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const ExcludeSemantics(
            child: Icon(
              Icons.auto_awesome_outlined,
              color: Color(0xFFC79945),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolIcon() {
    return const Center(
      child: Icon(
        Icons.school_outlined,
        color: _green,
        size: 36,
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Material(
      color: const Color(0xFFFFFCF7),
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildMenuRow(
            title: 'Terms & Conditions',
            icon: Icons.description_outlined,
            iconColor: const Color(0xFF7655CB),
            iconBackground: const Color(0xFFEDE5FC),
            onTap: () {
              Utils.openUrl(
                link: AppEndPoints.getTermLink,
              );
            },
          ),
          _buildDivider(),
          _buildMenuRow(
            title: 'Privacy & Security',
            icon: Icons.verified_user_outlined,
            iconColor: _green,
            iconBackground: const Color(0xFFE3EFE8),
            onTap: () {
              Utils.openUrl(
                link: AppEndPoints.getPrivacyPolicyLink,
              );
            },
          ),
          _buildDivider(),
          _buildMenuRow(
            title: 'About Us',
            icon: Icons.info_outline_rounded,
            iconColor: const Color(0xFF9B6B14),
            iconBackground: const Color(0xFFFFEFD0),
            onTap: () {
              Utils.openUrl(
                link: AppEndPoints.getAboutLink,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuRow({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _green,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              size: 24,
              color: Color(0xFF9A9C96),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFE8E4DC),
      ),
    );
  }

  Widget _buildLogout(BuildContext context) {
    return Material(
      color: const Color(0xFFFAEBE1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
        side: const BorderSide(
          color: Color(0xFFE39A77),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) {
              return CommonAlertDialog(
                title: "Logout",
                description: "Are you sure you want to logout?",
                yesButtonText: "Yes",
                noButtonText: "No",
                onYesPressed: () {
                  clearAllPreferences(context);
                },
                onNoPressed: () {
                  debugPrint("Cancelled");
                },
              );
            },
          );
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          child: Row(
            children: [
              Icon(
                Icons.logout_rounded,
                size: 24,
                color: Color(0xFFA74827),
              ),
              SizedBox(width: 18),
              Text(
                'Logout',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFA74827),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> clearAllPreferences(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!context.mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteName.loginScreen,
          (Route<dynamic> route) => false,
    );
  }

  Widget _buildPencilDecoration() {
    return ExcludeSemantics(
      child: SizedBox(
        width: 70,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.auto_awesome_outlined,
              size: 16,
              color: Color(0xFFC79945),
            ),
            const SizedBox(width: 8),
            Transform.rotate(
              angle: -0.35,
              child: const Icon(
                Icons.edit_outlined,
                size: 31,
                color: Color(0xFFD89F58),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Column(
      children: [
        Text(
          '© Manovikas Mulyankan Sanstha 2025',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            height: 1.5,
            color: Color(0xFF898B86),
          ),
        ),
      ],
    );
  }

  Widget _buildBooksDecoration() {
    return ExcludeSemantics(
      child: SizedBox(
        height: 105,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Icon(
                Icons.eco_outlined,
                size: 42,
                color: Color(0xFF819B83),
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.menu_book_rounded,
              size: 90,
              color: Color(0xFF819B83),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Transform.rotate(
                angle: 0.65,
                child: const Icon(
                  Icons.edit_outlined,
                  size: 40,
                  color: Color(0xFFD89F58),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}