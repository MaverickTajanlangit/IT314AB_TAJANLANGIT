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

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                students[index].isFavorite
                                    ? '${students[index].name} added to favorites'
                                    : '${students[index].name} removed from favorites',
                              ),
                            ),
                          );
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