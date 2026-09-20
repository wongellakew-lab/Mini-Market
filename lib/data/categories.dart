import 'package:flutter/material.dart';

/// Supported storefront categories.
const List<String> kCategories = [
  'smartphones',
  'audio',
  'clothing',
  'computers',
  'photography',
  'accessories',
  'furniture',
];

IconData iconForCategory(String category) {
  switch (category.toLowerCase()) {
    case 'smartphones':
      return Icons.phone_android;
    case 'audio':
      return Icons.headphones;
    case 'clothing':
      return Icons.checkroom;
    case 'computers':
      return Icons.laptop_chromebook;
    case 'photography':
      return Icons.photo_camera;
    case 'accessories':
      return Icons.backpack;
    case 'furniture':
      return Icons.light;
    default:
      return Icons.shopping_bag;
  }
}

Color colorForCategory(String category) {
  switch (category.toLowerCase()) {
    case 'smartphones':
      return const Color(0xFF2563EB); // blue
    case 'audio':
      return const Color(0xFF0D9488); // teal/green
    case 'clothing':
      return const Color(0xFFC2410C); // orange
    case 'computers':
      return const Color(0xFF7C3AED); // purple
    case 'photography':
      return const Color(0xFF4D7C0F); // olive
    case 'accessories':
      return const Color(0xFFBE185D); // magenta/pink
    case 'furniture':
      return const Color(0xFFB45309); // amber
    default:
      return const Color(0xFF475569); // slate grey
  }
}

Color bgColorForCategory(String category) {
  switch (category.toLowerCase()) {
    case 'smartphones':
      return const Color(0xFFE8EEFD);
    case 'audio':
      return const Color(0xFFE6F5F1);
    case 'clothing':
      return const Color(0xFFFDF0E8);
    case 'computers':
      return const Color(0xFFF3E8FF);
    case 'photography':
      return const Color(0xFFEFF8EA);
    case 'accessories':
      return const Color(0xFFFDE8F3);
    case 'furniture':
      return const Color(0xFFFEF3C7);
    default:
      return const Color(0xFFF1F5F9);
  }
}
