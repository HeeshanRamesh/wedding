import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const baseUrl = 'http://localhost:5000/api/user';

  // Get token from SharedPreferences
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // GET /profile
  static Future<Map<String, dynamic>?> getProfile() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  // PUT /update-profile
  static Future<bool> updateName(String name) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/update-profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"name": name}),
    );
    return response.statusCode == 200;
  }

  // PUT /update-profile (for email)
  static Future<bool> updateEmail(String email) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/update-profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"email": email}),
    );
    return response.statusCode == 200;
  }

   // PUT /update-profile (for email)
  static Future<bool> updatePhone(String phone) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/update-profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"phone": phone}),
    );
    return response.statusCode == 200;
  }

  static Future<Map<String, dynamic>?> getVendorSetup() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/vendor-setup'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['vendorProfile'];
    }
    return null;
  }

  // PUT /vendor-setup
  static Future<bool> updateVendorSetup(Map<String, dynamic> data) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/vendor-setup'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response.statusCode == 200;
  }

  // inside user_service.dart
  static Future<bool> updateAvailability(List<String> unavailableDates) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/vendor-availability'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"unavailableDates": unavailableDates}),
    );
    return response.statusCode == 200;
  }

  // user_service.dart
  static Future<bool> saveVendorService(Map<String, dynamic> data) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/add-service'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response.statusCode == 200;
  }

// user_service.dart
  static Future<bool> addVendorPackage(Map<String, dynamic> data) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/package'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    return response.statusCode == 201;
  }


  static Future<bool> addTask(Map<String, dynamic> taskData) async {
  try {
    final token = await _getToken();

    if (token == null) {
      print('⚠️ Token is null');
      return false;
    }

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
      print('❌ Failed to add task: ${response.body}');
      return false;
    }
  } catch (e) {
    print('🚨 Error adding task: $e');
    return false;
  }
}

static Future<List<Map<String, dynamic>>> getTasks() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/task'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['tasks']);
    } else {
      print('❌ Failed to fetch tasks: ${response.body}');
      return [];
    }
  }


static Future<Map<String, dynamic>?> getSubtasks(int taskIndex) async {
    final token = await _getToken();

    if (token == null) {
      print('❌ No token found in getSubtasks');
      return null;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/task/$taskIndex/subtasks'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('📥 Subtask API STATUS: ${response.statusCode}');
    print('📥 Subtask API BODY: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('❌ Failed to load subtasks: ${response.body}');
      return null;
    }
  }

}








