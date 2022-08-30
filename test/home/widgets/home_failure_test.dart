// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/home/home.dart';
import 'package:rick_and_morty/l10n/l10n.dart';

void main() {
  group('HomeFailure', () {
    testWidgets('renders failure text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: HomeFailure()),
        ),
      );
      expect(find.text('There was an error.'), findsOneWidget);
    });
  });
}
