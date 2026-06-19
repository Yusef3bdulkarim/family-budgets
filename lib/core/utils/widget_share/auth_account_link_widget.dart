import 'package:flutter/material.dart';

import '../../theme/app_text_styles.dart';

class AuthAccountLinkWidget extends StatelessWidget {
  final String message;
  final String actionLabel;
  final VoidCallback onPressed;

  const AuthAccountLinkWidget({
    super.key,
    required this.message,
    required this.actionLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message, style: AppTextStyles.bodyMedium),
        TextButton(
          onPressed: onPressed,
          child: Text(actionLabel),
        ),
      ],
    );
  }
}
