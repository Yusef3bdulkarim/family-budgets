import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class FamilySettingsAutoApprovalRowWidget extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const FamilySettingsAutoApprovalRowWidget({
    super.key,
    required this.enabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text('Enable auto-approval', style: AppTextStyles.bodyMedium),
        ),
        Switch(
          value: enabled,
          activeThumbColor: AppColors.secondary,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
