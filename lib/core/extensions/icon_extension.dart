import 'package:flutter/material.dart';

extension IconExtension on String {
  IconData toIcon() {
    switch (this) {
      case "emoji_events":
        return Icons.emoji_events;

      case "workspace_premium":
        return Icons.workspace_premium;

      case "military_tech":
        return Icons.military_tech;

      case "school":
        return Icons.school;

      case "menu_book":
        return Icons.menu_book;

      case "flag":
        return Icons.flag;

      default:
        return Icons.emoji_events_outlined;
    }
  }
}