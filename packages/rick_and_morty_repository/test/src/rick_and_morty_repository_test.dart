// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

void main() {
  group('RickAndMortyRepository', () {
    test('can be instantiated', () {
      expect(RickAndMortyRepository(), isNotNull);
    });
  });
}
