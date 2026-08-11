import 'package:flutter/material.dart';

import '../../models/guardian.dart';
import 'compact_header.dart';

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
        CompactHeader(
          guardian: guardian,
          onChangeChild: onChangeChild,
        ),

        const SizedBox(height: 0),
      ],
    );
  }
}