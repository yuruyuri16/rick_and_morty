import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

void main() {
  group('Character', () {
    Character createSubject({
      int id = 1,
      String name = 'mock-name-1',
      String status = 'mock-status-1',
      String species = 'mock-species-1',
      String image = 'mock-image-1',
      String url = 'mock-url-1',
    }) {
      return Character(
        id: id,
        name: name,
        status: status,
        species: species,
        image: image,
        url: url,
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(createSubject, returnsNormally);
      });
    });

    test('supports value equality', () {
      expect(createSubject(), equals(createSubject()));
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals([
          1,
          'mock-name-1',
          'mock-status-1',
          'mock-species-1',
          'mock-image-1',
          'mock-url-1',
        ]),
      );
    });

    group('fromJson', () {
      test('works correctly', () {
        final json = {
          'id': 1,
          'name': 'mock-name-1',
          'status': 'mock-status-1',
          'species': 'mock-species-1',
          'image': 'mock-image-1',
          'url': 'mock-url-1',
        };
        expect(Character.fromJson(json), equals(createSubject()));
      });
    });
  });
}
