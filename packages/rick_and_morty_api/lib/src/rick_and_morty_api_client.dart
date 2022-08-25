import 'package:dio/dio.dart';
import 'package:rick_and_morty_api/src/models/character.dart';

///
typedef JsonType = Map<String, dynamic>;

/// {@template rick_and_morty_api}
/// Dart API Client which wraps the
/// [Rick and Morty API](https://rickandmortyapi.com/documentation/#rest)
/// {@endtemplate}
class RickAndMortyApiClient {
  /// {@macro rick_and_morty_api}
  RickAndMortyApiClient({
    Dio? httpClient,
  }) : _httpClient = (httpClient ?? Dio())..options.baseUrl = _baseUrl;

  final Dio _httpClient;
  static const _baseUrl = 'https://rickandmortyapi.com/api';

  ///
  Future<List<Character>> getCharacters({int page = 1}) async {
    try {
      final response = await _httpClient.get<JsonType>(
        '/character',
        queryParameters: {'page': page},
      );
      if (response.data == null) throw Exception();
      final charactersList = response.data?['results'] as List<dynamic>;
      return charactersList
          .map((json) => Character.fromJson(json as JsonType))
          .toList();
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}
