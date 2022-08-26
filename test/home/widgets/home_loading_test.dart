// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/home/home.dart';

void main() {
  group('HomeLoading', () {
    testWidgets('renders CircularProgressIndicator', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: HomeLoading())));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
