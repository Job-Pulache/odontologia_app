import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AppSection extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const AppSection({
    super.key,
    required this.title,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -.4,
              ),
            ),
          ),

          if (action != null)
            TextButton(
              onPressed: onAction,

              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(40, 30),
              ),

              child: Text(
                action!,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
