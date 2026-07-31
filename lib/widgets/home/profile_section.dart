import 'package:flutter/material.dart';

import '../../models/guardian.dart';
import '../profile_guardian_card.dart';

class ProfileSection extends StatelessWidget {
  final Guardian? guardian;
  final Future<void> Function() onPressed;

  const ProfileSection({
    super.key,
    required this.guardian,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileGuardianCard(
      guardian: guardian,
      onPressed: onPressed,
    );
  }
}