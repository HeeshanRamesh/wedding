import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GuestService {
  static const baseUrl = 'http://localhost:5000/api/guests';

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // ➕ Add Guest
  static Future<bool> addGuest({
    required String name,
    required String side,
    required String phone,
    required String category,
  }) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/add'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'side': side.toLowerCase(),
        'phone': phone,
        'category': category.toLowerCase(),
      }),
    );

    return response.statusCode == 201;
  }

  // 📥 Get All Guests
  static Future<List<Map<String, dynamic>>> getGuests() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('🧪 Response Status: ${response.statusCode}');
    print('🧪 Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final guests = List<Map<String, dynamic>>.from(body['guests']);
      print('🧪 Parsed Guests: $guests');
      return guests;
    } else {
      return [];
    }
  }


  static Future<bool> sendInvitations(List<String> guestIds) async {
    final token = await _getToken();
    final url = Uri.parse('$baseUrl/send-invitations');

    print("Sending invitation request to: $url");
    print("Guest IDs: $guestIds");

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'guestIds': guestIds}),
    );

    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");

    return response.statusCode == 200;
  }


}
