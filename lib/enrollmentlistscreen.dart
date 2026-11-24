
import 'package:flutter/material.dart';

import 'enrollment_api.dart';
import 'student_api.dart';
import 'addenrollmentscreen.dart';

class EnrollmentListScreen extends StatefulWidget {
  const EnrollmentListScreen({super.key});

  @override
  State<EnrollmentListScreen> createState() =>
      _EnrollmentListScreenState();
}

class _EnrollmentListScreenState
    extends State<EnrollmentListScreen> {
  List<dynamic> enrollments = [];
  List<dynamic> students = [];
  List<dynamic> subjects = [];
  List<dynamic> schedules = [];

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final results = await Future.wait([
        EnrollmentApi.getEnrollments(),
        EnrollmentApi.getSubjects(),
        EnrollmentApi.getSchedules(),
        StudentApi.getStudents(),
      ]);

      if (!mounted) return;

      setState(() {
        enrollments = results[0];
        subjects = results[1];
        schedules = results[2];
        students = results[3];
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  String getStudentName(dynamic studentId) {
    final student = students.firstWhere(
          (item) =>
      item['student_id'].toString() ==
          studentId.toString(),
      orElse: () => null,
    );

    if (student == null) {
      return 'Unknown Student';
    }

    return student['student_name']?.toString() ??
        'Unknown Student';
  }

  String getSubjectName(dynamic subjectId) {
    final subject = subjects.firstWhere(
          (item) =>
      item['subject_id'].toString() ==
          subjectId.toString(),
      orElse: () => null,
    );

    if (subject == null) {
      return 'Unknown Subject';
    }

    return '${subject['subject_code']} - '
        '${subject['subject_name']}';
  }

  String getScheduleDetails(dynamic scheduleId) {
    final schedule = schedules.firstWhere(
          (item) =>
      item['schedule_id'].toString() ==
          scheduleId.toString(),
      orElse: () => null,
    );

    if (schedule == null) {
      return 'Unknown Schedule';
    }

    return '${schedule['day_of_week']} | '
        '${schedule['start_time']} - '
        '${schedule['end_time']} | '
        '${schedule['room']}';
  }

  Future<void> editEnrollment(
      Map<String, dynamic> enrollment,
      ) async {
    int? selectedScheduleId =
    int.tryParse(enrollment['schedule_id'].toString());

    String selectedStatus =
    enrollment['status'].toString();

    final availableSchedules = schedules.where((schedule) {
      return schedule['subject_id'].toString() ==
          enrollment['subject_id'].toString();
    }).toList();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Enrollment'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<int>(
                    initialValue: selectedScheduleId,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Schedule',
                      border: OutlineInputBorder(),
                    ),
                    items: availableSchedules.map((schedule) {
                      final id = int.parse(
                        schedule['schedule_id'].toString(),
                      );

                      return DropdownMenuItem<int>(
                        value: id,
                        child: Text(
                          '${schedule['day_of_week']} - '
                              '${schedule['room']}',
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setDialogState(() {
                        selectedScheduleId = value;
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    initialValue: selectedStatus,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Enrolled',
                        child: Text('Enrolled'),
                      ),
                      DropdownMenuItem(
                        value: 'Dropped',
                        child: Text('Dropped'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() {
                          selectedStatus = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, false);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await EnrollmentApi.updateEnrollment(
                        enrollmentId:
                        int.parse(
                          enrollment['enrollment_id'].toString(),
                        ),
                        scheduleId: selectedScheduleId,
                        status: selectedStatus,
                      );

                      if (dialogContext.mounted) {
                        Navigator.pop(dialogContext, true);
                      }
                    } catch (error) {
                      if (!dialogContext.mounted) return;

                      ScaffoldMessenger.of(dialogContext)
                          .showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                        ),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == true) {
      await loadData();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enrollment updated successfully.'),
        ),
      );
    }
  }

  Future<void> deleteEnrollment(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Enrollment'),
          content: const Text(
            'Are you sure you want to delete this enrollment?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      await EnrollmentApi.deleteEnrollment(id);

      await loadData();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enrollment deleted successfully.'),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enrollment List'),
        actions: [
          IconButton(
            onPressed: loadData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
              const AddEnrollmentScreen(),
            ),
          );

          if (result == true) {
            await loadData();
          }
        },
        child: const Icon(Icons.add),
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : errorMessage != null
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(errorMessage!),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: loadData,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      )
          : enrollments.isEmpty
          ? const Center(
        child: Text(
          'No enrollment records found.',
        ),
      )
          : RefreshIndicator(
        onRefresh: loadData,
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: enrollments.length,
          itemBuilder: (context, index) {
            final enrollment =
            Map<String, dynamic>.from(
              enrollments[index],
            );

            final id = int.parse(
              enrollment['enrollment_id']
                  .toString(),
            );

            final status =
            enrollment['status'].toString();

            return Card(
              margin: const EdgeInsets.only(
                bottom: 12,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      getStudentName(
                        enrollment['student_id'],
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      getSubjectName(
                        enrollment['subject_id'],
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      getScheduleDetails(
                        enrollment['schedule_id'],
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text('Enrollment ID: $id'),
                    Text('Status: $status'),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            editEnrollment(enrollment);
                          },
                          icon: const Icon(
                            Icons.edit,
                          ),
                          label: const Text('Edit'),
                        ),

                        TextButton.icon(
                          onPressed: () {
                            deleteEnrollment(id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          label: const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
