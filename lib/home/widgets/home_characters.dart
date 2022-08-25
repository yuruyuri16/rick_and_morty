import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/home/home.dart';

class HomeCharacters extends StatefulWidget {
  const HomeCharacters({super.key});

  @override
  State<HomeCharacters> createState() => _HomeCharactersState();
}

class _HomeCharactersState extends State<HomeCharacters> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final characters = context.select(
      (HomeBloc element) => element.state.characters,
    );
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      controller: _scrollController,
      itemCount: characters.length,
      itemBuilder: (_, index) {
        final character = characters[index];
        return CharacterCard(character: character);
      },
    );
  }

  void _onScroll() {
    if (_isBottom) context.read<HomeBloc>().add(HomeGetCharacters());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
