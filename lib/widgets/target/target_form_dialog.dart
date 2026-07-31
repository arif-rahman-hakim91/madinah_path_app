import 'package:flutter/material.dart';

import '../../models/target.dart';

class TargetFormDialog extends StatelessWidget {
  final Target? target;
  final Widget child;

  const TargetFormDialog({
    super.key,
    this.target,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        target == null
            ? "Tambah Target"
            : "Edit Target",
      ),
      content: child,
    );
  }
}