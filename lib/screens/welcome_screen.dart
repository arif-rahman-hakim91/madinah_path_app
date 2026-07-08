import 'package:flutter/material.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.mosque,
                  size: 80,
                  color: Colors.green,
                ),
                SizedBox(height: 20,),
                Text("بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
                ),
                Text("Madinah Path",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: 25),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                        ),
                    );
                  },
                    child: const Text("Mulai",style: TextStyle(
                        fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
  }
}