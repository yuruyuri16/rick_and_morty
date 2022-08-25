import 'package:flutter/material.dart';
import 'package:rick_and_morty/l10n/l10n.dart';

class HomeFailure extends StatelessWidget {
  const HomeFailure({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(child: Text(l10n.homeFailureText));
  }
}
