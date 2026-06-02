import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  // LOGIN
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse(
      'https://omniforsda-kranditadus.ngrok-free.dev/api/login',
    );

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'my-api-key': 'AKMAL-API-KEY',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    return jsonDecode(response.body);
  }

  // GET NOTES
  Future<List<dynamic>> getNotes(String token) async {
    final url = Uri.parse(
      'https://omniforsda-kranditadus.ngrok-free.dev/api/notes',
    );

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'my-api-key': 'AKMAL-API-KEY',
      },
    );

    return jsonDecode(response.body);
  }

  // CREATE NOTE
  Future<void> createNote(String token, String title, String content) async {
    final url = Uri.parse(
      'https://omniforsda-kranditadus.ngrok-free.dev/api/notes',
    );

    await http.post(
      url,

      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'my-api-key': 'AKMAL-API-KEY',
      },

      body: jsonEncode({'title': title, 'content': content}),
    );
  }

  // UPDATE NOTE
  Future<void> updateNote(
    String token,
    String id,
    String title,
    String content,
  ) async {
    final url = Uri.parse(
      'https://omniforsda-kranditadus.ngrok-free.dev/api/notes/$id',
    );

    await http.put(
      url,

      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'my-api-key': 'AKMAL-API-KEY',
      },

      body: jsonEncode({'title': title, 'content': content}),
    );
  }

  // DELETE NOTE
  Future<void> deleteNote(String token, String id) async {
    final url = Uri.parse(
      'https://omniforsda-kranditadus.ngrok-free.dev/api/notes/$id',
    );

    await http.delete(
      url,

      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'my-api-key': 'AKMAL-API-KEY',
      },
    );
  }
}
