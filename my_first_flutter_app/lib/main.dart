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
        backgroundColor: const Color(0xFF8FA28A),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Card
              SizedBox(
                width: 340,
                child: Card(
                  color: const Color(0xFFC7D3C0),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Image
                        ClipOval(
                          child: Image.asset(
                            'assets/profile.png',
                            width: 105,
                            height: 105,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Full Name
                        const Text(
                          'Maverick Tajanlangit',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'serif',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Course & Section
                        const Text(
                          'BS Information Technology - 3rd Year',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'serif',
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Application Title
                        const Text(
                          'My First Flutter Application',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'serif',
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Date
                        const Text(
                          'August 11, 2026',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'serif',
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Hobby
                        const Text(
                          'Hobby: Dancing',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'serif',
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Age and Birthdate
                        SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Age: 20',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'serif',
                                  fontSize: 15,
                                ),
                              ),
                              const Text(
                                'Birthdate: May 23, 2005',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'serif',
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),

              const SizedBox(height: 18),

              // My Faves Card
              SizedBox(
                width: 340,
                child: Card(
                  color: const Color(0xFFC7D3C0),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'My Faves',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'serif',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Fave Game - Imposter Game',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'serif',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Fave Food - Buldak',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'serif',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Fave Movie - Harry Potter',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'serif',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}