// ignore_for_file: prefer_const_constructors
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

class MockDio extends Mock implements Dio {}

class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  group('RickAndMortyApiClient', () {
    late Dio dio;
    late RickAndMortyApiClient rickAndMortyApiClient;

    setUp(() {
      dio = MockDio();
      // rickAndMortyApiClient = RickAndMortyApiClient(httpClient: dio);
    });

    group('constructor', () {
      test('does not require a dio client', () {
        expect(RickAndMortyApiClient(), isNotNull);
      });
    });

    group('getCharacters', () {});
  });
}
