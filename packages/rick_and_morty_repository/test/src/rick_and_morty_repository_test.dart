// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class MockRickAndMortyApiClient extends Mock implements RickAndMortyApiClient {}

void main() {
  group('RickAndMortyRepository', () {
    late RickAndMortyApiClient rickAndMortyApiClient;
    late RickAndMortyRepository rickAndMortyRepository;

    final characters = [
      Character(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
        url: 'https://rickandmortyapi.com/api/character/1',
      )
    ];

    setUp(() {
      rickAndMortyApiClient = MockRickAndMortyApiClient();
      rickAndMortyRepository = RickAndMortyRepository(
        ramApiClient: rickAndMortyApiClient,
      );
    });

    group('constructor', () {
      test('does not require a Rick and Morty client', () {
        expect(RickAndMortyRepository(), isNotNull);
      });
    });

    group('getCharacters', () {
      test('calls getCharacters', () async {
        try {
          await rickAndMortyRepository.getCharacters();
        } catch (_) {}
        verify(() => rickAndMortyApiClient.getCharacters()).called(1);
      });

      test('throws when there is an error', () {
        final exception = Exception('error');
        when(() => rickAndMortyApiClient.getCharacters()).thenThrow(exception);
        expect(
          () async => rickAndMortyRepository.getCharacters(),
          throwsA(exception),
        );
      });

      test('returns correct list of characters on success', () async {
        when(() => rickAndMortyApiClient.getCharacters())
            .thenAnswer((_) async => characters);
        final result = await rickAndMortyRepository.getCharacters();
        expect(result, characters);
      });
    });
  });
}
