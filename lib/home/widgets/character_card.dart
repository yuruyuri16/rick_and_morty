import 'package:flutter/material.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Card(
        child: Row(
          children: <Widget>[
            Image.network(
              character.image,
              width: size.width * 0.3,
              height: size.width * 0.3,
            ),
            _CharacterInfo(character: character),
          ],
        ),
      ),
    );
  }
}

class _CharacterInfo extends StatelessWidget {
  const _CharacterInfo({required this.character});

  final Character character;
  static const statusColor = {
    'Alive': Color(0XFF76C958),
    'Dead': Color(0XFFC54838),
    'unknown': Color(0XFF9F9E9E),
  };

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              character.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: statusColor[character.status],
                    shape: BoxShape.circle,
                  ),
                  width: 12,
                  height: 12,
                ),
                const SizedBox(width: 6),
                Text(
                  '${character.status.capitalized} - ${character.species}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension on String {
  String get capitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
