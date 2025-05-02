import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  static const String baseUrl = 'http://localhost:5000/api/user';

  static Future<bool> addTask(Map<String, dynamic> taskData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.post(
        Uri.parse('$baseUrl/task'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(taskData),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Failed to add task: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error adding task: $e');
      return false;
    }
  }
}
