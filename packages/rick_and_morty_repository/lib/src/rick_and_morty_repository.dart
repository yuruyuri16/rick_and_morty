import 'package:rick_and_morty_api/rick_and_morty_api.dart';

/// {@template rick_and_morty_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class RickAndMortyRepository {
  /// {@macro rick_and_morty_repository}
  RickAndMortyRepository({RickAndMortyApiClient? ramApiClient})
      : _ramApiClient = ramApiClient ?? RickAndMortyApiClient();

  final RickAndMortyApiClient _ramApiClient;

  ///
  Future<List<Character>> getCharacters({int page = 1}) async {
    return _ramApiClient.getCharacters(page: page);
  }
}
