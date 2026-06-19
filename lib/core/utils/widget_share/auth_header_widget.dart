import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextAlign textAlign;

  const AuthHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.h1, textAlign: textAlign),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: textAlign,
        ),
      ],
    );
  }
}
