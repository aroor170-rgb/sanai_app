import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'app_config.dart';

class ApiService {
  static Future<List<dynamic>> getItems() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();

    final url = Uri.parse('${AppConfig.baseUrl}/items');
    final res = await http.get(
      url,
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      return (data['items'] as List<dynamic>);
    } else {
      throw Exception('Error ${res.statusCode}: ${res.body}');
    }
  }
}