import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_text_style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Logo
                Image.asset(
                  "assets/images/logo.png",
                  width: 170,
                ),

                const SizedBox(height: 28),

                // Nama aplikasi
                Text(
                  "Madinah Path",
                  style: AppTextStyle.headline,
                ),

                const SizedBox(height: 20),

                // Divider
                Row(
                  children: [

                    Expanded(
                      child: Container(
                        height: 2,
                        color: AppColors.gold,
                      ),
                    ),

                    const SizedBox(width: 12),

                    SvgPicture.asset(
                      "assets/svg/madinah_gate.svg",
                      width: 20,
                      height: 20,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Container(
                        height: 2,
                        color: AppColors.gold,
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 24),

                Text(
                  "Langkah Menuju Ilmu",
                  style: AppTextStyle.body,
                ),

                const SizedBox(height: 40),

                Text(
                  "v0.4.0",
                  style: AppTextStyle.caption,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}