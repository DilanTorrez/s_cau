import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:s_cau/Util/api.dart';
import 'package:s_cau/models/socioModel.dart';

class SocioService {
  final String apiUrl = '$api/partner';

  Future<List<Socio>> getSocios() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Socio> socios =
          body.map((dynamic item) => Socio.fromJson(item)).toList();
      return socios;
    } else {
      throw Exception('Failed to load partners');
    }
  }

  Future<Socio> getSocio(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      if (body.isNotEmpty) {
        Socio socio = Socio.fromJson(body.first);
        return socio;
      } else {
        throw Exception('Partner with id $id not found');
      }
    } else {
      throw Exception('Failed to load partner');
    }
  }

  Future<void> createSocio(Socio socio) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(socio),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create partner');
    }
  }

  Future<void> updateSocio(int id, Socio socio) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(socio),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update partner');
    }
  }

  Future<void> deleteSocio(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete partner');
    }
  }
}
