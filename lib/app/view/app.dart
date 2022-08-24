// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/home/home.dart';
import 'package:rick_and_morty/l10n/l10n.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required RickAndMortyRepository rickAndMortyRepository})
      : _rickAndMortyRepository = rickAndMortyRepository;

  final RickAndMortyRepository _rickAndMortyRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _rickAndMortyRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF202329)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
        textTheme: GoogleFonts.promptTextTheme(),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
