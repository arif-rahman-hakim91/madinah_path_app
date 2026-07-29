import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'core/theme/app_theme.dart';


void main() {
  runApp(const MadinahPathApp());
}

class MadinahPathApp extends StatelessWidget {
  const MadinahPathApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const WelcomeScreen(),

    );
  }
}