import 'package:flutter/material.dart';

class HomeEmpty extends StatelessWidget {
  const HomeEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(
      key: Key('home_empty_sizedbox'),
    );
  }
}
