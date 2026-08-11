import 'package:flutter/material.dart';

class DashboardNavigationSection extends StatelessWidget {
  final List<Widget> children;

  const DashboardNavigationSection({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth =
            (constraints.maxWidth - 8) / 2;

        return Wrap(
          spacing: 4,
          runSpacing: 4,
          children: children.map((child) {
            return SizedBox(
              width: itemWidth,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }
}