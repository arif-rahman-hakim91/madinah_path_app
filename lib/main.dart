import 'package:flutter/material.dart';

void main() {
  runApp(const MadinahPathApp());
}

class MadinahPathApp extends StatelessWidget {
  const MadinahPathApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.school,
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
                SizedBox(height: 25,),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(onPressed: () {},
                      child: const Text("Mulai",style: TextStyle(
                          fontWeight: FontWeight.bold),
                      ),
                  ),
                )
              ],
            ),
        ),
      )
    );
  }
}