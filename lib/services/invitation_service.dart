import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InvitationService {
  static const String baseUrl = 'http://localhost:5000/api/invitations';

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<bool> saveInvitationSettings({
    required String weddingDate,
    required int sendBeforeDays,
  }) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/settings'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "weddingDate": weddingDate,
        "sendBeforeDays": sendBeforeDays,
      }),
    );

    return response.statusCode == 200;
  }
}
