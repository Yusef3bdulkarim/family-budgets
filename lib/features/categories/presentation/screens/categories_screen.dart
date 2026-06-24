import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/category_entity.dart';
import '../bloc/categories_cubit.dart';
import '../bloc/categories_state.dart';
import '../widgets/category_form_sheet.dart';
import '../widgets/category_list_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().loadCategories();
  }

  void _showFormSheet({CategoryEntity? existing}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => CategoryFormSheet(
        existing: existing,
        onSave: ({required name, required icon, required colorValue}) {
          final cubit = context.read<CategoriesCubit>();
          if (existing == null) {
            cubit.createCategory(
                name: name, icon: icon, colorValue: colorValue);
          } else {
            cubit.updateCategory(
                id: existing.id,
                name: name,
                icon: icon,
                colorValue: colorValue);
          }
        },
      ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, CategoryEntity category) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Category'),
        content: Text(
            'Delete "${category.name}"? It will be hidden from new requests.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child:
                const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      context.read<CategoriesCubit>().deleteCategory(category.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is CategoriesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CategoriesError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () =>
                        context.read<CategoriesCubit>().loadCategories(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final categories = switch (state) {
            CategoriesLoaded(:final categories) => categories,
            CategoriesMutating(:final categories) => categories,
            _ => <CategoryEntity>[],
          };

          final canManage = switch (state) {
            CategoriesLoaded(:final canManage) => canManage,
            CategoriesMutating(:final canManage) => canManage,
            _ => false,
          };

          final isMutating = state is CategoriesMutating;

          if (categories.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.category_outlined,
                      size: 48, color: Colors.grey),
                  const SizedBox(height: 12),
                  const Text('No categories yet'),
                  if (canManage) ...[
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () => _showFormSheet(),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Category'),
                    ),
                  ],
                ],
              ),
            );
          }

          return Stack(
            children: [
              ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryListItem(
                    category: category,
                    canManage: canManage,
                    onEdit: () => _showFormSheet(existing: category),
                    onDelete: () => _confirmDelete(context, category),
                  );
                },
              ),
              if (isMutating)
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(),
                ),
            ],
          );
        },
      ),
      floatingActionButton: Builder(builder: (context) {
        final state = context.watch<CategoriesCubit>().state;
        final canManage = switch (state) {
          CategoriesLoaded(:final canManage) => canManage,
          CategoriesMutating(:final canManage) => canManage,
          _ => false,
        };
        if (!canManage) return const SizedBox.shrink();
        return FloatingActionButton(
          onPressed: () => _showFormSheet(),
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
