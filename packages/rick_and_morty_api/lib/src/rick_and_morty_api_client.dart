import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  }) : httpClient = (httpClient ?? Dio())..options.baseUrl = _baseUrl;

  @visibleForTesting
  final Dio httpClient;
  static const _baseUrl = 'https://rickandmortyapi.com/api';

  ///
  Future<List<Character>> getCharacters({int page = 1}) async {
    try {
      final response = await httpClient.get<JsonType>(
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
