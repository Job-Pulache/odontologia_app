import 'package:flutter/material.dart';

class SearchItem {
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final String type;
  final String imageUrl;

  SearchItem({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.type,
    required this.imageUrl,
  });
}
