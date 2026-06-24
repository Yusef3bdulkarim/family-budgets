import 'package:flutter/material.dart';

import '../../../../core/constants/family_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class FamilySettingsBudgetDayRowWidget extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const FamilySettingsBudgetDayRowWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text('Budget starts on day', style: AppTextStyles.bodyMedium),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: value,
              items: List.generate(
                FamilyConstants.maxBudgetStartDay,
                (i) => DropdownMenuItem(value: i + 1, child: Text('${i + 1}')),
              ),
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ],
      ),
    );
  }
}
