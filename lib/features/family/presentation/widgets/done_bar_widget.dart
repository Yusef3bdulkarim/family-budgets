import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class DoneBarWidget extends StatelessWidget {
  const DoneBarWidget({
    super.key,
    required this.enabled,
    required this.onDone,
  });

  final bool enabled;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),
      child: ElevatedButton(
        onPressed: enabled ? onDone : null,
        child: const Text('Done — Enter the App'),
      ),
    );
  }
}
