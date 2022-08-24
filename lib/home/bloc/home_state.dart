part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == HomeStatus.initial;
  bool get isLoading => this == HomeStatus.loading;
  bool get isSuccess => this == HomeStatus.success;
  bool get isFailure => this == HomeStatus.failure;
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.characters = const <Character>[],
    this.hasReachedMax = false,
    this.page = 1,
  });

  final HomeStatus status;
  final List<Character> characters;
  final bool hasReachedMax;
  final int page;

  @override
  List<Object> get props => [status, characters, hasReachedMax, page];

  HomeState copyWith({
    HomeStatus? status,
    List<Character>? characters,
    bool? hasReachedMax,
    int? page,
  }) {
    return HomeState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }
}
