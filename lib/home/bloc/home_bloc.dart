import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._rickAndMortyRepository) : super(const HomeState()) {
    on<HomeGetCharacters>(_onGetCharacters);
  }

  final RickAndMortyRepository _rickAndMortyRepository;

  Future<void> _onGetCharacters(
    HomeGetCharacters event,
    Emitter<HomeState> emit,
  ) async {
    if (state.page > 42) {
      emit(state.copyWith(characters: state.characters, hasReachedMax: true));
      return;
    }
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final characters =
          await _rickAndMortyRepository.getCharacters(page: state.page);
      emit(
        state.copyWith(
          status: HomeStatus.success,
          characters: List<Character>.from(state.characters)
            ..addAll(characters),
          page: state.page + 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          characters: state.characters,
        ),
      );
    }
  }
}
