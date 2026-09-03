import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Student {
  String image;
  String name;
  String course;
  String yearLevel;
  int age;
  String hobby;
  String studentId;
  String email;
  String favoriteSubject;

  Student({
    required this.image,
    required this.name,
    required this.course,
    required this.yearLevel,
    required this.age,
    required this.hobby,
    required this.studentId,
    required this.email,
    required this.favoriteSubject,
  });
}

List<Student> students = [
  Student(
    image: 'assets/student1.jpg',
    name: 'Maverick Tajanlangit',
    course: 'BS Information Technology',
    yearLevel: '3rd Year',
    age: 20,
    hobby: 'Dancing',
    studentId: '0001',
    email: 'maverick@mamamail.com',
    favoriteSubject: 'Programming',
  ),
  Student(
    image: 'assets/student2.jpg',
    name: 'Maria Santos',
    course: 'BS Information Technology',
    yearLevel: '3rd Year',
    age: 20,
    hobby: 'Reading',
    studentId: '0002',
    email: 'maria@mamamail.com',
    favoriteSubject: 'Database',
  ),
  Student(
    image: 'assets/student3.jpg',
    name: 'John Cruz',
    course: 'BS Information Technology',
    yearLevel: '2nd Year',
    age: 19,
    hobby: 'Gaming',
    studentId: '0003',
    email: 'john@mamamail.com',
    favoriteSubject: 'Web Development',
  ),
  Student(
    image: 'assets/student4.jpg',
    name: 'Aaron Reyes',
    course: 'BS Information Technology',
    yearLevel: '1st Year',
    age: 18,
    hobby: 'Basketball',
    studentId: '0004',
    email: 'aaron@mamamail.com',
    favoriteSubject: 'Computer Fundamentals',
  ),
  Student(
    image: 'assets/student5.jpg',
    name: 'Sophia Garcia',
    course: 'BS Information Technology',
    yearLevel: '3rd Year',
    age: 21,
    hobby: 'Photography',
    studentId: '0005',
    email: 'sophia@mamamail.com',
    favoriteSubject: 'Networking',
  ),
  Student(
    image: 'assets/student6.jpg',
    name: 'Daniel Flores',
    course: 'BS Information Technology',
    yearLevel: '2nd Year',
    age: 19,
    hobby: 'Drawing',
    studentId: '0006',
    email: 'daniel@mamamail.com',
    favoriteSubject: 'Mobile Development',
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    students.sort(
      (a, b) => a.name.compareTo(b.name),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Student list'),
        ),
        body: students.isEmpty
            ? const Center(
                child: Text(
                  'No students found.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            students[index].image,
                          ),
                        ),
                        title: Text(
                          students[index].name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${students[index].course}\n'
                          '${students[index].yearLevel}\n'
                          'Age: ${students[index].age}\n'
                          'Hobby: ${students[index].hobby}\n'
                          'Student ID: ${students[index].studentId}\n'
                          'Email: ${students[index].email}\n'
                          'Favorite Subject: ${students[index].favoriteSubject}',
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}=