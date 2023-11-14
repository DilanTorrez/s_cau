import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:s_cau/Util/api.dart';
import 'package:s_cau/models/usuario.dart';

class AuthModel extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  int? _userId;
  int? get userId => _userId;

  final String apiUrl = '$api/user';

  Future<void> login(String username, String password) async {
    // Realiza una solicitud a la API para verificar la autenticidad del usuario

    final response = await http.get(
      Uri.parse('$apiUrl?username=$username&password=$password'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      if (body.isNotEmpty) {
        Usuario usuario = Usuario.fromJson(body.first);
        _isAuthenticated = true;
        _userId = usuario.id;
      } else {
        throw Exception(
            'El usuario con el nombre $username o contraseña no existe');
      }
    } else {
      throw Exception('Error de autenticación');
    }

    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _userId = null;
    notifyListeners();
  }
}
