
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'student_api.dart';

class EnrollmentApi {
  static const String baseUrl = StudentApi.baseUrl;

  // GET: Retrieve all enrollments.
  static Future<List<dynamic>> getEnrollments() async {
    final response = await http.get(
      Uri.parse('$baseUrl/enrollments/'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }

    throw Exception(
      'Failed to load enrollments: ${response.body}',
    );
  }

  // GET: Retrieve one enrollment.
  static Future<Map<String, dynamic>> getEnrollment(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/enrollments/$id'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception(
      'Failed to load enrollment: ${response.body}',
    );
  }

  // GET: Retrieve all subjects.
  static Future<List<dynamic>> getSubjects() async {
    final response = await http.get(
      Uri.parse('$baseUrl/subjects/'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }

    throw Exception(
      'Failed to load subjects: ${response.body}',
    );
  }

  // GET: Retrieve all schedules.
  static Future<List<dynamic>> getSchedules() async {
    final response = await http.get(
      Uri.parse('$baseUrl/schedules/'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    }

    throw Exception(
      'Failed to load schedules: ${response.body}',
    );
  }

  // POST: Create an enrollment.
  static Future<Map<String, dynamic>> addEnrollment({
    required int studentId,
    required int subjectId,
    required int scheduleId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/enrollments/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'student_id': studentId,
        'subject_id': subjectId,
        'schedule_id': scheduleId,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception(
      'Failed to add enrollment: ${response.body}',
    );
  }

  // PUT: Update an enrollment.
  static Future<Map<String, dynamic>> updateEnrollment({
    required int enrollmentId,
    int? scheduleId,
    String? status,
  }) async {
    final Map<String, dynamic> data = {};

    if (scheduleId != null) {
      data['schedule_id'] = scheduleId;
    }

    if (status != null) {
      data['status'] = status;
    }

    final response = await http.put(
      Uri.parse('$baseUrl/enrollments/$enrollmentId'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }

    throw Exception(
      'Failed to update enrollment: ${response.body}',
    );
  }

  // DELETE: Remove an enrollment.
  static Future<void> deleteEnrollment(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/enrollments/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to delete enrollment: ${response.body}',
      );
    }
  }
}
