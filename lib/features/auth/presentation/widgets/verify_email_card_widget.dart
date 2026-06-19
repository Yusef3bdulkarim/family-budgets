import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class VerifyEmailCardWidget extends StatelessWidget {
  final String maskedEmail;
  final VoidCallback onChangeEmail;

  const VerifyEmailCardWidget({
    super.key,
    required this.maskedEmail,
    required this.onChangeEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.email_outlined,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VERIFICATION SENT TO',
                      style: AppTextStyles.caption.copyWith(
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(maskedEmail, style: AppTextStyles.labelLarge),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          TextButton(
            onPressed: onChangeEmail,
            child: Text(
              'Change Email',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
