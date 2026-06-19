import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class VerifyEmailActionsWidget extends StatelessWidget {
  final bool canResend;
  final int resendCooldown;
  final VoidCallback onResend;
  final VoidCallback onOpenEmailApp;

  const VerifyEmailActionsWidget({
    super.key,
    required this.canResend,
    required this.resendCooldown,
    required this.onResend,
    required this.onOpenEmailApp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onOpenEmailApp,
            icon: const Icon(Icons.open_in_new),
            label: const Text('Open Email App'),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: canResend ? onResend : null,
          child: Text(
            'Resend Email',
            style: AppTextStyles.labelMedium.copyWith(
              color: canResend ? AppColors.primary : AppColors.textHint,
            ),
          ),
        ),
        if (!canResend)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.access_time, size: 14, color: AppColors.textHint),
              const SizedBox(width: 4),
              Text(
                'Resend available in ${resendCooldown}s',
                style: AppTextStyles.caption,
              ),
            ],
          ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user, size: 16, color: AppColors.success),
            const SizedBox(width: 6),
            Text(
              'Secure Budget Environment',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
