import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Requests')),
      body: Center(
        child: Text('Requests — Coming Soon', style: AppTextStyles.bodyLarge),
      ),
    );
  }
}
