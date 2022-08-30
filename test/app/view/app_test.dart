// ignore_for_file: prefer_const_constructors

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/app/app.dart';
import 'package:rick_and_morty/home/home.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class MockRickAndMortyRepository extends Mock
    implements RickAndMortyRepository {}

void main() {
  group('App', () {
    late RickAndMortyRepository rickAndMortyRepository;

    setUp(() {
      rickAndMortyRepository = MockRickAndMortyRepository();
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(rickAndMortyRepository: rickAndMortyRepository),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late RickAndMortyRepository rickAndMortyRepository;

    setUp(() {
      rickAndMortyRepository = MockRickAndMortyRepository();
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: rickAndMortyRepository,
          child: AppView(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
