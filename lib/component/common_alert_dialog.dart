import 'package:flutter/material.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/utils.dart';


class CommonAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final String yesButtonText;
  final String noButtonText;
  final VoidCallback? onYesPressed;
  final VoidCallback? onNoPressed;

  const CommonAlertDialog({
    super.key,
    required this.title,
    required this.description,
    this.yesButtonText = "Yes",
    this.noButtonText = "No",
    this.onYesPressed,
    this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      content: SizedBox(height: 90,
        child: Column(
          children: [
            Text(description, style: const TextStyle(fontSize: 16)),
            10.height,

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(8)
                        ),
                      ),
                      side: BorderSide(color: Colors.grey.shade400),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (onYesPressed != null) onNoPressed!();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              10.width,
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.colorPrimaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                         Radius.circular(8)
                        ),
                      ),
                      side: BorderSide(color: Colors.grey.shade400),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (onYesPressed != null) onYesPressed!();
                    },
                    child: const Text(
                      'Log out',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
}
