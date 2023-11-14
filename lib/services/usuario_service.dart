import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:s_cau/models/usuario.dart';
import 'package:s_cau/Util/api.dart';

class UsuarioService {
  final String apiUrl = '$api/user';

  Future<List<Usuario>> getUsuarios() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Usuario> usuarios =
          body.map((dynamic item) => Usuario.fromJson(item)).toList();
      return usuarios;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<Usuario> getUsuario(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      if (body.isNotEmpty) {
        Usuario usuario = Usuario.fromJson(body.first);
        return usuario;
      } else {
        throw Exception('User with id $id not found');
      }
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<void> createUsuario(Usuario usuario) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usuario),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create user');
    }
  }

  Future<void> updateUsuario(int id, Usuario usuario) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usuario),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }

  Future<void> deleteUsuario(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}
