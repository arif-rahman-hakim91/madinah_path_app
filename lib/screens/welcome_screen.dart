import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_screen.dart';
import '../core/theme/app_colors.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 220,
                  height: 220,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),

                const Text(
                  "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 3,
                        color: const Color(0xFFD4AF37),
                      ),
                    ),

                    const SizedBox(width: 12),

                    SvgPicture.asset(
                      "assets/svg/madinah_gate_start.svg",
                      width: 24,
                      height: 24,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Container(
                        height: 3,
                        color: const Color(0xFFD4AF37),
                      ),
                    ),
                  ],
                ),

                Text(
                  "Madinah Path",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 42,fontWeight: FontWeight.bold),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 2,
                        color: const Color(0xFFD4AF37),
                      ),
                    ),

                    const SizedBox(width: 12),

                    SvgPicture.asset(
                      "assets/svg/madinah_gate_start.svg",
                      width: 24,
                      height: 24,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Container(
                        height: 2,
                        color: const Color(0xFFD4AF37),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 52),

                Text(
                  "مَنْ سَلَكَ طَرِيقًا يَلْتَمِسُ فِيهِ عِلْمًا سَهَّلَ اللَّهُ لَهُ بِهِ طَرِيقًا إِلَى الْجَنَّةِ",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Barang siapa menempuh suatu jalan untuk mencari ilmu, Allah akan mudahkan baginya jalan menuju surga.",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "(HR. Muslim no. 2699)",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 44),

                Container(
                  width: double.infinity,
                  height: 56,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37), // Emas
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Mulai Belajar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _FeatureItem(
                      icon: Icons.menu_book_rounded,
                      label: "Hafalan",
                    ),
                    _FeatureItem(
                      icon: Icons.mosque_rounded,
                      label: "Ibadah",
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _FeatureItem(
                      icon: Icons.flag_rounded,
                      label: "Target",
                    ),
                    _FeatureItem(
                      icon: Icons.workspace_premium_rounded,
                      label: "Reward",
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Text(
                  "v0.5.0-dev",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}