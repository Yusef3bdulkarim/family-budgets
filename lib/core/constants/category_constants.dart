abstract final class CategoryConstants {
  static const maxNameLength = 50;

  static const defaultIcon = 'other';

  static const validIconKeys = <String>{
    'food',
    'transport',
    'education',
    'entertainment',
    'clothing',
    'health',
    'savings',
    'shopping',
    'utilities',
    'travel',
    'gifts',
    'other',
  };

  static const presetColors = <int>[
    0xFF4CAF50,
    0xFF2196F3,
    0xFFF44336,
    0xFFFF9800,
    0xFF9C27B0,
    0xFF00BCD4,
    0xFF795548,
    0xFF607D8B,
    0xFFE91E63,
    0xFFFFEB3B,
    0xFF009688,
    0xFF3F51B5,
  ];

  static int get defaultColor => presetColors.first;
}
