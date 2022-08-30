import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/home/home.dart';
import 'package:rick_and_morty/l10n/l10n.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(context.read<RickAndMortyRepository>())
        ..add(HomeGetCharacters()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeAppBarTitle)),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const HomeLoading();
          } else if (state.status.isSuccess) {
            return const HomeCharacters();
          } else if (state.status.isFailure) {
            return const HomeFailure();
          } else {
            return const HomeEmpty();
          }
        },
      ),
    );
  }
}
