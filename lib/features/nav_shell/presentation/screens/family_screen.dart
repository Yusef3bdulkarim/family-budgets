import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Family')),
      body: Center(
        child: Text('Family — Coming Soon', style: AppTextStyles.bodyLarge),
      ),
    );
  }
}
