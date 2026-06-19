import 'package:flutter/material.dart';

class AuthSocialButtonsWidget extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;

  const AuthSocialButtonsWidget({
    super.key,
    required this.onGooglePressed,
    required this.onApplePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onGooglePressed,
            icon: const Icon(Icons.g_mobiledata, size: 24),
            label: const Text('Google'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onApplePressed,
            icon: const Icon(Icons.apple, size: 24),
            label: const Text('Apple'),
          ),
        ),
      ],
    );
  }
}
