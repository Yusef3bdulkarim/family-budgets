import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: Center(
        child: Text('More — Coming Soon', style: AppTextStyles.bodyLarge),
      ),
    );
  }
}
