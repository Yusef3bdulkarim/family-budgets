import 'package:flutter/material.dart';

abstract final class CategoryIcons {
  static const Map<String, IconData> map = {
    'food': Icons.restaurant,
    'transport': Icons.directions_car,
    'education': Icons.school,
    'entertainment': Icons.movie,
    'clothing': Icons.checkroom,
    'health': Icons.local_hospital,
    'savings': Icons.savings,
    'shopping': Icons.shopping_bag,
    'utilities': Icons.electrical_services,
    'travel': Icons.flight,
    'gifts': Icons.card_giftcard,
    'other': Icons.category,
  };
}
