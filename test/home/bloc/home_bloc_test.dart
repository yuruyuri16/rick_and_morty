// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/home/home.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class MockRickAndMortyRepository extends Mock
    implements RickAndMortyRepository {}

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  group('HomeBloc', () {
    late RickAndMortyRepository rickAndMortyRepository;

    setUp(() {
      rickAndMortyRepository = MockRickAndMortyRepository();
    });

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

    test('initial state is correct', () {
      expect(HomeBloc(rickAndMortyRepository).state, equals(HomeState()));
    });

    group('HomeGetCharacters', () {
      blocTest<HomeBloc, HomeState>(
        'emits [loading, success] when getCharacters is successful.',
        setUp: () => when(rickAndMortyRepository.getCharacters)
            .thenAnswer((_) async => characters),
        build: () => HomeBloc(rickAndMortyRepository),
        act: (bloc) => bloc.add(HomeGetCharacters()),
        expect: () => <HomeState>[
          HomeState(status: HomeStatus.loading),
          HomeState(
            status: HomeStatus.success,
            characters: characters,
            page: 2,
          ),
        ],
        verify: (_) => verify(rickAndMortyRepository.getCharacters).called(1),
      );

      blocTest<HomeBloc, HomeState>(
        'emits [loading, failure] when getCharacters fails.',
        setUp: () => when(rickAndMortyRepository.getCharacters).thenThrow({}),
        build: () => HomeBloc(rickAndMortyRepository),
        act: (bloc) => bloc.add(HomeGetCharacters()),
        expect: () => <HomeState>[
          HomeState(status: HomeStatus.loading),
          HomeState(status: HomeStatus.failure),
        ],
        verify: (_) => verify(rickAndMortyRepository.getCharacters).called(1),
      );

      blocTest<HomeBloc, HomeState>(
        'emits nothing when hasReachedMax is true.',
        build: () => HomeBloc(rickAndMortyRepository),
        seed: () => HomeState(
          status: HomeStatus.success,
          characters: characters,
          hasReachedMax: true,
        ),
        act: (bloc) => bloc.add(HomeGetCharacters()),
        expect: () => <HomeState>[],
      );

      blocTest<HomeBloc, HomeState>(
        'emits hasReachedMax to true when page is 43 or more.',
        build: () => HomeBloc(rickAndMortyRepository),
        seed: () => HomeState(
          status: HomeStatus.success,
          characters: characters,
          page: 43,
        ),
        act: (bloc) => bloc.add(HomeGetCharacters()),
        expect: () => <HomeState>[
          HomeState(
            status: HomeStatus.success,
            characters: characters,
            hasReachedMax: true,
            page: 43,
          )
        ],
      );
    });
  });
}
