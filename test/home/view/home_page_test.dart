// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/home/home.dart';
import 'package:rick_and_morty/l10n/l10n.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class MockRickAndMortyRepository extends Mock
    implements RickAndMortyRepository {}

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  final characters = List.generate(
    3,
    (i) => Character(
      id: i,
      name: 'mock-character-id-$i',
      status: 'mock-character-status-$i',
      species: 'mock-character-species-$i',
      image: 'mock-character-image-$i',
      url: 'mock-character-url-$i',
    ),
  );
  group('HomePage', () {
    late final RickAndMortyRepository rickAndMortyRepository;

    setUp(() {
      rickAndMortyRepository = MockRickAndMortyRepository();
    });
    testWidgets('renders HomeView', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: rickAndMortyRepository,
          child: MaterialApp(
            home: HomePage(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  group('HomeView', () {
    late HomeBloc homeBloc;

    setUp(() {
      homeBloc = MockHomeBloc();
    });

    testWidgets(
        'renders HomeEmpty '
        'when home status is initial', (tester) async {
      when(() => homeBloc.state).thenReturn(HomeState());
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider.value(
            value: homeBloc,
            child: HomeView(),
          ),
        ),
      );
      expect(find.byType(HomeEmpty), findsOneWidget);
    });

    testWidgets(
        'renders HomeLoading '
        'when home status is loading', (tester) async {
      when(() => homeBloc.state).thenReturn(
        HomeState(status: HomeStatus.loading),
      );
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider.value(
            value: homeBloc,
            child: HomeView(),
          ),
        ),
      );
      expect(find.byType(HomeLoading), findsOneWidget);
    });

    testWidgets(
        'renders HomeCharacters '
        'when home status is success', (tester) async {
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
            child: HomeView(),
          ),
        ),
      );
      expect(find.byType(HomeCharacters), findsOneWidget);
      expect(find.byType(CharacterCard), findsNWidgets(3));
    });

    testWidgets('renders HomeFailure', (tester) async {
      when(() => homeBloc.state).thenReturn(
        HomeState(status: HomeStatus.failure),
      );
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider.value(
            value: homeBloc,
            child: HomeView(),
          ),
        ),
      );
      expect(find.byType(HomeFailure), findsOneWidget);
    });
  });
}
