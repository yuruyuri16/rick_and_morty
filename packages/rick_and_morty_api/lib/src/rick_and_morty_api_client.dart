import 'package:dio/dio.dart';
import 'package:rick_and_morty_api/src/models/character.dart';

/// Type for Map<String, dynamic>
typedef JsonType = Map<String, dynamic>;

/// {@template rick_and_morty_api}
/// Dart API Client which wraps the
/// [Rick and Morty API](https://rickandmortyapi.com/documentation/#rest)
/// {@endtemplate}
class RickAndMortyApiClient {
  /// {@macro rick_and_morty_api}
  RickAndMortyApiClient({
    Dio? dio,
  }) : _dio = (dio ?? Dio())..options.baseUrl = _baseUrl;

  final Dio _dio;
  static const _baseUrl = 'https://rickandmortyapi.com/api';

  ///
  Future<List<Character>> getCharacters({int page = 1}) async {
    try {
      final response = await _dio.get<JsonType>(
        '/character',
        queryParameters: {'page': page},
      );

      if (response.data == null) throw Exception();
      final charactersList = response.data?['results'] as List<dynamic>;
      return charactersList
          .map((json) => Character.fromJson(json as JsonType))
          .toList();
    } on DioError catch (_) {
      throw RickAndMortyFailure();
    }
  }
}

/// Exception when an error ocurred when getting the characters
class RickAndMortyFailure implements Exception {}
