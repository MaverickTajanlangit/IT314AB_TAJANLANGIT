
import 'package:flutter/material.dart';

import 'enrollment_api.dart';
import 'student_api.dart';

class AddEnrollmentScreen extends StatefulWidget {
  const AddEnrollmentScreen({super.key});

  @override
  State<AddEnrollmentScreen> createState() =>
      _AddEnrollmentScreenState();
}

class _AddEnrollmentScreenState
    extends State<AddEnrollmentScreen> {
  List<dynamic> students = [];
  List<dynamic> subjects = [];
  List<dynamic> schedules = [];

  int? selectedStudentId;
  int? selectedSubjectId;
  int? selectedScheduleId;

  bool isLoading = true;
  bool isSaving = false;

  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadDropdownData();
  }

  Future<void> loadDropdownData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final results = await Future.wait([
        StudentApi.getStudents(),
        EnrollmentApi.getSubjects(),
        EnrollmentApi.getSchedules(),
      ]);

      if (!mounted) return;

      setState(() {
        students = results[0];
        subjects = results[1];
        schedules = results[2];
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

  List<dynamic> get availableSchedules {
    if (selectedSubjectId == null) {
      return [];
    }

    return schedules.where((schedule) {
      return schedule['subject_id'].toString() ==
          selectedSubjectId.toString();
    }).toList();
  }

  String getScheduleLabel(dynamic schedule) {
    return '${schedule['day_of_week']} | '
        '${schedule['start_time']} - '
        '${schedule['end_time']} | '
        '${schedule['room']}';
  }

  Future<void> saveEnrollment() async {
    if (selectedStudentId == null ||
        selectedSubjectId == null ||
        selectedScheduleId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select all enrollment details.',
          ),
        ),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      await EnrollmentApi.addEnrollment(
        studentId: selectedStudentId!,
        subjectId: selectedSubjectId!,
        scheduleId: selectedScheduleId!,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Enrollment added successfully.',
          ),
        ),
      );

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Enrollment'),
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
                onPressed: loadDropdownData,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text(
              'Enrollment Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<int>(
              initialValue: selectedStudentId,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Select Student',
                border: OutlineInputBorder(),
              ),
              items: students.map((student) {
                final id = int.parse(
                  student['student_id'].toString(),
                );

                return DropdownMenuItem<int>(
                  value: id,
                  child: Text(
                    '${student['student_name']} (ID: $id)',
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStudentId = value;
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<int>(
              initialValue: selectedSubjectId,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Select Subject',
                border: OutlineInputBorder(),
              ),
              items: subjects.map((subject) {
                final id = int.parse(
                  subject['subject_id'].toString(),
                );

                return DropdownMenuItem<int>(
                  value: id,
                  child: Text(
                    '${subject['subject_code']} - '
                        '${subject['subject_name']}',
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSubjectId = value;
                  selectedScheduleId = null;
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<int>(
              initialValue: selectedScheduleId,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Select Schedule',
                border: OutlineInputBorder(),
              ),
              hint: Text(
                selectedSubjectId == null
                    ? 'Select a subject first'
                    : availableSchedules.isEmpty
                    ? 'No schedules available'
                    : 'Choose a schedule',
              ),
              items: availableSchedules.map((schedule) {
                final id = int.parse(
                  schedule['schedule_id'].toString(),
                );

                return DropdownMenuItem<int>(
                  value: id,
                  child: Text(
                    getScheduleLabel(schedule),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: selectedSubjectId == null ||
                  availableSchedules.isEmpty
                  ? null
                  : (value) {
                setState(() {
                  selectedScheduleId = value;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                isSaving ? null : saveEnrollment,
                child: isSaving
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : const Text('Save Enrollment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
