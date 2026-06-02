import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final _storageService = StorageService();

  String? _token;
  bool _isLoading = false;

  String? get token => _token;

  bool get isLoading => _isLoading;

  bool get isAuthenticated => _token != null;

  // Cek Session Saat App Dibuka
  Future<void> checkSession() async {
    _token = await _storageService.getToken();

    notifyListeners();
  }

  // LOGIN

  Future<bool> login(String email, String password) async {
    _isLoading = true;

    notifyListeners();

    // Ganti URL API Backend Anda
    final url = Uri.parse(
      'https://omniforsda-kranditadus.ngrok-free.dev/api/login',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'my-api-key': 'AKMAL-API-KEY',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        _token = data['token'];

        // Simpan JWT
        await _storageService.saveToken(_token!);

        notifyListeners();

        return true;
      }

      return false;
    } catch (e) {
      print('Error Login: $e');

      return false;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  // REGISTER
  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;

    notifyListeners();

    final url = Uri.parse(
      'https://omniforsda-kranditadus.ngrok-free.dev/api/register',
    );

    try {
      final response = await http.post(
        url,

        headers: {
          'Content-Type': 'application/json',
          'my-api-key': 'AKMAL-API-KEY',
        },

        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      return false;
    } catch (e) {
      print('Error Register: $e');

      return false;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  // LOGOUT
  Future<void> logout() async {
    _token = null;

    await _storageService.deleteToken();

    notifyListeners();
  }
}
