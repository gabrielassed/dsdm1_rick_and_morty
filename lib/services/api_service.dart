import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class ApiService {
  final _baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<Character>> fetchCharacters({int page = 1}) async {
    final uri = Uri.parse('$_baseUrl/character?page=$page');
    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw Exception('Erro ao carregar personagens: ${resp.statusCode}');
    }

    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>;
    return results
        .map((json) => Character.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
