
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pabulum_teacher/bloc/login/login_bloc.dart';
import 'package:pabulum_teacher/component/common_alert_dialog.dart';
import 'package:pabulum_teacher/model/profile_model.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      LoginBloc()..add(OnLoadProfileEvent()),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.background,
            bottomNavigationBar: Utils.navigationBar(),
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
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: CustomAppBar(
                              title: 'My Profile',
                              subtitle:
                              'Your teaching profile\nand account settings.',
                              image: AppImages.icProfileHeader,
                              showBackButton: false,
                            ),
                          ),
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return SingleChildScrollView(
                                  padding:
                                  const EdgeInsets.fromLTRB(
                                    16,
                                    0,
                                    16,
                                    18,
                                  ),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight:
                                      constraints.maxHeight,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: [
                                        _buildTeacherProfile(
                                          state.profileData,
                                        ),
                                        const SizedBox(height: 13),
                                        _buildSchool(
                                          state.profileData,
                                        ),
                                        const SizedBox(height: 22),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(
                                            left: 3,
                                            bottom: 11,
                                          ),
                                          child: Text(
                                            'Helpful information',
                                            style: TextStyle(
                                              color: AppColors.ink,
                                              fontSize: 17,
                                              fontWeight:
                                              FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        _buildMenu(context),
                                        const SizedBox(height: 15),
                                        _buildLogout(context),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.isLoading) Utils.loaderBrier(),
                if (state.isLoading) Utils.loaderWid(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTeacherProfile(
      ProfileData? profileData,
      ) {
    final accent = Utils.getCardBorderColor(0);

    return _buildBorderCard(
      accent: accent,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileImage(
              name: profileData?.name ?? '',
              imageUrl: profileData?.profileImage ?? '',
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: accent.withValues(
                        alpha: 0.10,
                      ),
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                    child: Text(
                      (profileData?.role ?? 'Teacher')
                          .toUpperCase(),
                      style: TextStyle(
                        color: accent,
                        fontSize: 10,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    _displayText(profileData?.name),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 18,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (profileData?.email?.isNotEmpty ==
                      true) ...[
                    const SizedBox(height: 6),
                    Text(
                      profileData?.email ?? '',
                      softWrap: true,
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage({
    required String name,
    required String imageUrl,
  }) {
    return Container(
      width: 76,
      height: 76,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.purple.withValues(
            alpha: 0.35,
          ),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: imageUrl.trim().isEmpty
            ? _buildInitials(name)
            : Image.network(
          imageUrl,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          loadingBuilder:
              (context, child, progress) {
            if (progress == null) {
              return child;
            }
            return _buildInitials(name);
          },
          errorBuilder:
              (context, error, stackTrace) {
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
      color: Utils.getCardBackgroundColor(0),
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w800,
          color: AppColors.purple,
        ),
      ),
    );
  }

  Widget _buildSchool(ProfileData? profileData) {
    final accent = Utils.getCardBorderColor(2);

    return _buildBorderCard(
      accent: accent,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 49,
              height: 49,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: accent.withValues(
                  alpha: 0.10,
                ),
                borderRadius:
                BorderRadius.circular(12),
              ),
              child: profileData
                  ?.school
                  ?.profileImage
                  ?.isNotEmpty ==
                  true
                  ? Image.network(
                profileData!
                    .school!
                    .profileImage!,
                fit: BoxFit.cover,
                loadingBuilder:
                    (context, child, progress) {
                  return progress == null
                      ? child
                      : _buildSchoolIcon(accent);
                },
                errorBuilder:
                    (context, error, stackTrace) {
                  return _buildSchoolIcon(accent);
                },
              )
                  : _buildSchoolIcon(accent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'MY SCHOOL',
                    style: TextStyle(
                      color: accent,
                      fontSize: 10,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _displayText(
                      profileData?.school?.name,
                    ),
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 15,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.school_rounded,
              color: accent,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchoolIcon(Color color) {
    return Center(
      child: Icon(
        Icons.school_outlined,
        color: color,
        size: 29,
      ),
    );
  }

  Widget _buildBorderCard({
    required Color accent,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(19),
      ),
      padding: const EdgeInsets.fromLTRB(
        1,
        5,
        1,
        1,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(13),
            topRight: Radius.circular(13),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
        ),
        child: child,
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.colorGrey1,
        ),
      ),
      child: Column(
        children: [
          _buildMenuRow(
            title: 'Terms & Conditions',
            icon: Icons.description_outlined,
            accent: Utils.getCardBorderColor(0),
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
            accent: Utils.getCardBorderColor(1),
            onTap: () {
              Utils.openUrl(
                link:
                AppEndPoints.getPrivacyPolicyLink,
              );
            },
          ),
          _buildDivider(),
          _buildMenuRow(
            title: 'About Us',
            icon: Icons.info_outline_rounded,
            accent: Utils.getCardBorderColor(4),
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
    required Color accent,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius:
                  BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  color: accent,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.muted,
                size: 23,
              ),
            ],
          ),
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
        thickness: 1,
        color: AppColors.colorGrey1,
      ),
    );
  }

  Widget _buildLogout(BuildContext context) {
    final accent = Utils.getCardBorderColor(3);

    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: accent.withValues(
            alpha: 0.55,
          ),
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
                title: 'Logout',
                description:
                'Are you sure you want to logout?',
                yesButtonText: 'Yes',
                noButtonText: 'No',
                onYesPressed: () {
                  clearAllPreferences(context);
                },
                onNoPressed: () {
                  debugPrint('Cancelled');
                },
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 13,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius:
                  BorderRadius.circular(11),
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: accent,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: accent,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: accent,
                size: 23,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> clearAllPreferences(
      BuildContext context,
      ) async {
    final prefs =
    await SharedPreferences.getInstance();

    await prefs.clear();

    if (!context.mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      RouteName.loginScreen,
          (Route<dynamic> route) => false,
    );
  }

  String _displayText(String? value) {
    final text = value?.trim() ?? '';
    return text.isEmpty ? '—' : text;
  }
}
