// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/home/home.dart';

void main() {
  group('HomeEmpty', () {
    testWidgets('renders SizedBox.shrink', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: HomeEmpty())));
      expect(find.byKey(Key('home_empty_sizedbox')), findsOneWidget);
    });
  });
}
