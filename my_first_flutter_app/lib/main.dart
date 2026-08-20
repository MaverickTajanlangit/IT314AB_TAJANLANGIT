import 'package:flutter/material.dart';

// ===============================
// PROFILE DATA MODEL
// ===============================

class Profile {
  final String image;
  final String? name;
  final String? course;
  final int age;
  final String? hobby;

  Profile({
    required this.image,
    this.name,
    this.course,
    required this.age,
    this.hobby,
  });
}

// ===============================
// FIVE PROFILE DATA
// ===============================

Profile maverick = Profile(
  image: "assets/profile.png",
  name: "Maverick Tajanlangit",
  course: "BPA - 3rd Year",
  age: 20,
  hobby: "Dancing",
);

Profile Bryan = Profile(
  image: "assets/profile2.png",
  name: "Bryan Quino",
  course: "BSIT - 3rd Year",
  age: 21,
);

Profile Leachim = Profile(
  image: "assets/profile3.png",
  name: "Leachim Dela Cerna",
  age: 22,
  hobby: "Clubbing",
);

Profile Julia = Profile(
  image: "assets/profile4.png",
  course: "BS Biology - 3rd Year",
  age: 23,
  hobby: "Cooking",
);

Profile James = Profile(
  image: "assets/profile5.png",
  name: "James Gulfan",
  course: "BPED - 3rd Year",
  age: 24,
);

// ===============================
// MAIN
// ===============================

void main() {
  runApp(const MyApp());
}

// ===============================
// MAIN APP
// ===============================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        backgroundColor: const Color(0xFF8FA28A),

        // ===============================
        // SCROLLING WIDGET
        // ===============================

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                // PROFILE 1
                ProfileCard(
                  profile: maverick,
                ),

                const SizedBox(height: 15),

                // PROFILE 2
                ProfileCard(
                  profile: Bryan,
                ),

                const SizedBox(height: 15),

                // PROFILE 3
                ProfileCard(
                  profile: Leachim,
                ),

                const SizedBox(height: 15),

                // PROFILE 4
                ProfileCard(
                  profile: Julia,
                ),

                const SizedBox(height: 15),

                // PROFILE 5
                ProfileCard(
                  profile: James,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===============================
// REUSABLE PROFILE CARD
// ===============================

class ProfileCard extends StatelessWidget {
  final Profile profile;

  const ProfileCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,

      child: Card(
        color: const Color(0xFFC7D3C0),

        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              // PROFILE IMAGE
              ClipOval(
                child: Image.asset(
                  profile.image,
                  width: 105,
                  height: 105,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 15),

              // NAME
              Text(
                profile.name ?? "Not provided",

                textAlign: TextAlign.center,

                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'serif',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 8),

              // COURSE
              Text(
                profile.course ?? "Course not provided",

                textAlign: TextAlign.center,

                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'serif',
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 8),

              // AGE
              Text(
                "Age: ${profile.age}",

                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'serif',
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 8),

              // HOBBY
              Text(
                "Hobby: ${profile.hobby ?? "Not provided"}",

                textAlign: TextAlign.center,

                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'serif',
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}