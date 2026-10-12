
import 'package:flutter/material.dart';
import 'package:pabulum_teacher/utils/app_color.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback? onBack;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.onBack,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (showBackButton)
            Positioned(
              top: 8,
              left: 0,
              child: Material(
                color: AppColors.purple,
                elevation: 4,
                shadowColor:
                AppColors.purple.withValues(alpha: 0.35),
                shape: CircleBorder(
                  side: BorderSide(
                    color: AppColors.white,
                    width: 2,
                  ),
                ),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onBack ?? () => Navigator.pop(context),
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),

          Positioned(
            top: 66,
            left: 4,
            right: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 13,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 13,
            right: 0,
            child: Image.asset(
              image,
              width: 138,
              height: 138,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
