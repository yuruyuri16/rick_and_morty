import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'home_event.dart';
part 'home_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._rickAndMortyRepository) : super(const HomeState()) {
    on<HomeGetCharacters>(
      _onGetCharacters,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final RickAndMortyRepository _rickAndMortyRepository;

  Future<void> _onGetCharacters(
    HomeGetCharacters event,
    Emitter<HomeState> emit,
  ) async {
    if (state.hasReachedMax) return;
    if (state.page > 42) {
      emit(state.copyWith(hasReachedMax: true));
      return;
    }
    if (state.status.isInitial) {
      emit(state.copyWith(status: HomeStatus.loading));
    }
    try {
      final characters =
          await _rickAndMortyRepository.getCharacters(page: state.page);
      emit(
        state.copyWith(
          status: HomeStatus.success,
          characters: List.from(state.characters)..addAll(characters),
          page: state.page + 1,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
