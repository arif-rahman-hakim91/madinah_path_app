import 'package:flutter/material.dart';

class DashboardNavigationSection extends StatelessWidget {
  final List<Widget> children;

  const DashboardNavigationSection({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children,
    );
  }
}