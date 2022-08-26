// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/home/home.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

void main() {
  final character = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    url: 'https://rickandmortyapi.com/api/character/1',
  );
  group('CharacterCard', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CharacterCard(character: character),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CachedNetworkImage), findsOneWidget);
      expect(find.text(character.name), findsOneWidget);
      expect(find.byKey(Key('character_card_key')), findsOneWidget);
      expect(
        find.text('${character.status.capitalized} - ${character.species}'),
        findsOneWidget,
      );
    });
  });
}
