import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      body: Center(
        child: Text('Goals — Coming Soon', style: AppTextStyles.bodyLarge),
      ),
    );
  }
}
