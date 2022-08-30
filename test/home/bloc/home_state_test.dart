// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/home/home.dart';

void main() {
  group('HomeState', () {
    test('supports value comparison', () {
      expect(HomeState(), HomeState());
      expect(HomeState().toString(), HomeState().toString());
    });
  });
}
