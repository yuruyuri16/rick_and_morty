import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/home/home.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class HomeLoaded extends StatelessWidget {
  const HomeLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;
    return InfiniteList(
      scrollExtentThreshold: 600,
      itemCount: state.characters.length,
      onFetchData: () => context.read<HomeBloc>().add(HomeGetCharacters()),
      itemBuilder: (_, index) {
        final character = state.characters[index];
        return CharacterCard(character: character);
      },
    );
  }
}
