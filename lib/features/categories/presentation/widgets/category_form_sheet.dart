import 'package:flutter/material.dart';

import '../../../../core/constants/category_constants.dart';
import '../../../../core/constants/category_icons.dart';
import '../../domain/entities/category_entity.dart';

class CategoryFormSheet extends StatefulWidget {
  final CategoryEntity? existing;
  final void Function({
    required String name,
    required String icon,
    required int colorValue,
  }) onSave;

  const CategoryFormSheet({
    super.key,
    this.existing,
    required this.onSave,
  });

  @override
  State<CategoryFormSheet> createState() => _CategoryFormSheetState();
}

class _CategoryFormSheetState extends State<CategoryFormSheet> {
  late final TextEditingController _nameController;
  late String _selectedIcon;
  late int _selectedColor;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.existing?.name ?? '');
    _selectedIcon =
        widget.existing?.icon ?? CategoryConstants.defaultIcon;
    _selectedColor =
        widget.existing?.colorValue ?? CategoryConstants.defaultColor;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category name cannot be empty')),
      );
      return;
    }
    widget.onSave(
      name: name,
      icon: _selectedIcon,
      colorValue: _selectedColor,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEdit ? 'Edit Category' : 'New Category',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            maxLength: CategoryConstants.maxNameLength,
            decoration: const InputDecoration(
              labelText: 'Category name',
              border: OutlineInputBorder(),
              counterText: '',
            ),
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 20),
          Text('Icon', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: CategoryIcons.map.length,
              itemBuilder: (context, index) {
                final entry =
                    CategoryIcons.map.entries.elementAt(index);
                final isSelected = entry.key == _selectedIcon;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedIcon = entry.key),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Color(_selectedColor)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      entry.value,
                      color: isSelected ? Colors.white : Colors.black54,
                      size: 22,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text('Color', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: CategoryConstants.presetColors.map((colorValue) {
              final isSelected = colorValue == _selectedColor;
              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedColor = colorValue),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Color(colorValue),
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(
                            color: Colors.black,
                            width: 3,
                          )
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: _submit,
                  child: Text(isEdit ? 'Save' : 'Add'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
