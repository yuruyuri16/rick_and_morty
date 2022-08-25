// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

void main() {
  group('RickAndMortyApiClient', () {
    test('can be instantiated', () {
      expect(RickAndMortyApiClient(), isNotNull);
    });
  });
}
