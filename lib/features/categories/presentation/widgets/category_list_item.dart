import 'package:flutter/material.dart';

import '../../../../core/constants/category_icons.dart';
import '../../domain/entities/category_entity.dart';

class CategoryListItem extends StatelessWidget {
  final CategoryEntity category;
  final bool canManage;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CategoryListItem({
    super.key,
    required this.category,
    required this.canManage,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final icon =
        CategoryIcons.map[category.icon] ?? Icons.category;
    final color = Color(category.colorValue);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      title: Text(category.name),
      subtitle: category.isDefault ? const Text('Default') : null,
      trailing: canManage
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  tooltip: 'Edit',
                  onPressed: onEdit,
                ),
                if (!category.isDefault)
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Delete',
                    onPressed: onDelete,
                  ),
              ],
            )
          : null,
    );
  }
}
