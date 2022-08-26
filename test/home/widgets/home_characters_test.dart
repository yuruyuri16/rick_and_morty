// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/home/home.dart';
import 'package:rick_and_morty/l10n/l10n.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  final characters = List.generate(
    3,
    (i) => Character(
      id: i,
      name: 'mock-character-name-$i',
      status: 'mock-character-status-$i',
      species: 'mock-character-species-$i',
      image: 'mock-character-image-$i',
      url: 'mock-character-url-$i',
    ),
  );

  late final HomeBloc homeBloc;

  setUp(() {
    homeBloc = MockHomeBloc();
  });

  group('HomeCharacters', () {
    testWidgets('renders 3 characters correctly', (tester) async {
      when(() => homeBloc.state).thenReturn(
        HomeState(
          status: HomeStatus.success,
          characters: characters,
          page: 2,
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider.value(
            value: homeBloc,
            child: HomeCharacters(),
          ),
        ),
      );
      expect(find.byType(CharacterCard), findsNWidgets(3));
    });

    testWidgets('fetches more characters when scrolled to the bottom',
        (tester) async {
      when(() => homeBloc.state).thenReturn(
        HomeState(
          status: HomeStatus.success,
          characters: characters,
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider.value(
            value: homeBloc,
            child: HomeCharacters(),
          ),
        ),
      );
      await tester.drag(find.byType(HomeCharacters), Offset(0, -600));
      verify(() => homeBloc.add(HomeGetCharacters())).called(1);
    });
  });
}
