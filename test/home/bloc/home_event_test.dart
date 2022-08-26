import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/home/home.dart';

void main() {
  group('HomeEvent', () {
    group('HomeGetCharacters', () {
      test('supports value comparison', () {
        expect(HomeGetCharacters(), HomeGetCharacters());
      });
    });
  });
}
