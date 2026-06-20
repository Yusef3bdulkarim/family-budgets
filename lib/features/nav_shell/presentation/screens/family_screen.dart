import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';

class FamilyScreen extends StatelessWidget {
  const FamilyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Family')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: Text('Manage Categories', style: AppTextStyles.bodyLarge),
            subtitle: const Text('Add, edit, or remove spending categories'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.categories),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
