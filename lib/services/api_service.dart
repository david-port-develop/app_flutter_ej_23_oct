import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country_model.dart';
import '../models/user_model.dart';

class ApiService {
  static const String _baseUrl = "https://reqres.in/api";
  static const Map<String, String> _headers = {'x-api-key': 'reqres-free-v1'};

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> userList = data['data'];
        return userList.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Country>> fetchCountries() async {
    // Pedimos solo los campos que necesitamos para optimizar la respuesta.
    final response = await http.get(
      Uri.parse('https://restcountries.com/v3.1/all?fields=name,capital'),
    );

    if (response.statusCode == 200) {
      // La respuesta es una lista de JSON, no un objeto.
      // Usamos utf8.decode para manejar caracteres especiales como tildes.
      final List<dynamic> countryList = json.decode(
        utf8.decode(response.bodyBytes),
      );
      return countryList.map((json) => Country.fromJson(json)).toList()
        // Ordenamos los países alfabéticamente por nombre.
        ..sort((a, b) => a.name.compareTo(b.name));
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
