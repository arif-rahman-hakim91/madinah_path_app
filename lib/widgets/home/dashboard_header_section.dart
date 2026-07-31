import 'package:flutter/material.dart';

import '../../models/guardian.dart';
import '../../core/theme/app_spacing.dart';
import '../active_child_card.dart';
import '../greeting_header.dart';

class DashboardHeaderSection extends StatelessWidget {
  final Guardian? guardian;
  final VoidCallback onChangeChild;

  const DashboardHeaderSection({
    super.key,
    required this.guardian,
    required this.onChangeChild,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GreetingHeader(
          guardian: guardian,
        ),
        AppSpacing.verticalLg,
        ActiveChildCard(
          onChangeChild: onChangeChild,
        ),
      ],
    );
  }
}