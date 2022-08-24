// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

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

    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(
        App(rickAndMortyRepository: rickAndMortyRepository),
      );
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
          child: const AppView(),
        ),
      );
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
