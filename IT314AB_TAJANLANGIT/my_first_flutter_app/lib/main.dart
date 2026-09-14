import 'dart:async';
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
  bool isFavorite;
  bool isActive;

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
    this.isFavorite = false,
    this.isActive = true,
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
    isActive: true,
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
    isActive: false,
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
    isActive: true,
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
    isActive: false,
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
    isActive: true,
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
    isActive: true,
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StudentList(),
    );
  }
}

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void showEditDialog(Student student) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Student'),
          content: Text(
            'You selected ${student.name} for editing.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    students.sort(
          (a, b) => a.name.compareTo(b.name),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student list'),
      ),
      body: isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 15),
            Text(
              'Loading students...',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      )
          : students.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 80,
            ),
            SizedBox(height: 15),
            Text(
              'No students found',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'The student directory is empty.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
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
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${students[index].name} card tapped',
                          ),
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            students[index].image,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                students[index].name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${students[index].course}\n'
                                    '${students[index].yearLevel}\n'
                                    'Age: ${students[index].age}\n'
                                    'Hobby: ${students[index].hobby}\n'
                                    'Student ID: ${students[index].studentId}\n'
                                    'Email: ${students[index].email}\n'
                                    'Favorite Subject: ${students[index].favoriteSubject}',
                              ),
                              const SizedBox(height: 8),
                              Text(
                                students[index].isActive
                                    ? 'Active'
                                    : 'Inactive',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (students[index].isFavorite)
                                const Text(
                                  '★ Favorite',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          students[index].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        onPressed: () {
                          setState(() {
                            students[index].isFavorite =
                            !students[index].isFavorite;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showEditDialog(students[index]);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          String deletedStudent =
                              students[index].name;

                          setState(() {
                            students.removeAt(index);
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '$deletedStudent deleted',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}