import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventService {
  static const String baseUrl = 'http://localhost:5000/api/events'; // Adjust for production

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<bool> addEvent(String name, String date) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"name": name, "date": date}),
    );
    return response.statusCode == 201;
  }

  static Future<List<Map<String, dynamic>>> getMyEvents() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/my-events'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['events']);
    } else {
      throw Exception('Failed to load events: ${response.statusCode}');
    }
  }

  static Future<bool> updateEvent(String eventId, String name, String date) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/$eventId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"name": name, "date": date}),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteEvent(String eventId) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/$eventId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    return response.statusCode == 200;
  }
}