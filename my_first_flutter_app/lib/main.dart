import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFA8B5A2),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Image
              ClipOval(
                child: Image.asset(
                  'assets/profile.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 25),

              // Full Name
              const Text(
                'Maverick Tajanlangit',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'serif',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 15),

              // Course & Section
              const Text(
                'BS Information Technology - 2nd Year',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'serif',
                  fontSize: 19,
                ),
              ),

              const SizedBox(height: 15),

              // Application Title
              const Text(
                'My First Flutter Application',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'serif',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 15),

              // Date
              const Text(
                'August 11, 2026',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'serif',
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}