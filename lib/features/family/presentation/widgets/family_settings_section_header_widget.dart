import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class FamilySettingsSectionHeaderWidget extends StatelessWidget {
  final String title;
  const FamilySettingsSectionHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.bodyLarge.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}
