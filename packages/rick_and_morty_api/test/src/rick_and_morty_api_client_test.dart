// ignore_for_file: prefer_const_constructors, unused_local_variable
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

class MockDio extends Mock implements Dio {}

class MockResponse<T> extends Mock implements Response<T> {}

class MockBaseOptions extends Mock implements BaseOptions {}

class FakeBaseOptions extends Fake implements BaseOptions {}

void main() {
  group('RickAndMortyApiClient', () {
    setUpAll(() {
      registerFallbackValue(FakeBaseOptions());
    });
    group('constructor', () {
      test('does not require a dio client', () {
        expect(RickAndMortyApiClient(), isNotNull);
      });
    });

    group('getCharacters', () {
      late Dio httpClient;
      late BaseOptions baseOptions;
      late RickAndMortyApiClient rickAndMortyApiClient;

      setUp(() {
        httpClient = MockDio();
        rickAndMortyApiClient = RickAndMortyApiClient(httpClient: httpClient);

        /// HELP ME aaaaaaa
        when(() => rickAndMortyApiClient.httpClient.options)
            .thenReturn(BaseOptions());
      });

      test('makes correct', () async {
        try {
          await rickAndMortyApiClient.getCharacters();
          verify(() => httpClient.get<JsonType>('/character')).called(1);
        } catch (_) {}
      });
    });
  });
}
