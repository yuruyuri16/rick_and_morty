// ignore_for_file: prefer_const_constructors
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

class MockDio extends Mock implements Dio {}

class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  group('RickAndMortyApiClient', () {
    group('constructor', () {
      test('does not require a dio client', () {
        expect(RickAndMortyApiClient(), isNotNull);
      });
    });

    group('getCharacters', () {
      late Dio dio;
      late RickAndMortyApiClient rickAndMortyApiClient;

      setUp(() {
        dio = MockDio();
        when(() => dio.options).thenReturn(BaseOptions());
        rickAndMortyApiClient = RickAndMortyApiClient(dio: dio);
      });

      test('makes correct http request without a page', () async {
        final response = MockResponse<JsonType>();
        when(() => response.statusCode).thenReturn(200);
        when(() => dio.get<JsonType>(any())).thenAnswer((_) async => response);
        try {
          await rickAndMortyApiClient.getCharacters();
        } catch (_) {}
        verify(
          () => dio.get<JsonType>(
            '/character',
            queryParameters: {'page': 1},
          ),
        ).called(1);
      });

      test('makes correct http request with a page', () async {
        final response = MockResponse<JsonType>();
        when(() => response.statusCode).thenReturn(200);
        when(() => dio.get<JsonType>(any())).thenAnswer((_) async => response);
        try {
          await rickAndMortyApiClient.getCharacters(page: 10);
        } catch (_) {}
        verify(
          () => dio.get<JsonType>('/character', queryParameters: {'page': 10}),
        ).called(1);
      });

      test('returns list of characters on valid response', () async {
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
        final response = MockResponse<JsonType>();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.data).thenReturn({
          'results': <JsonType>[
            {
              'id': 1,
              'name': 'Rick Sanchez',
              'status': 'Alive',
              'species': 'Human',
              'image':
                  'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
              'url': 'https://rickandmortyapi.com/api/character/1',
            }
          ]
        });
        when(
          () => dio.get<JsonType>(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => response);
        final list = await rickAndMortyApiClient.getCharacters();
        expect(list, isA<List<Character>>());
        expect(list, characters);
      });

      test('throws when there is an error', () async {
        when(
          () => dio.get<JsonType>(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(
          DioError(requestOptions: RequestOptions(path: '/character')),
        );
        expect(
          () => rickAndMortyApiClient.getCharacters(),
          throwsA(isA<RickAndMortyFailure>()),
        );
      });
    });
  });
}
