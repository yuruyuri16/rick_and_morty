import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_repository/rick_and_morty_repository.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl: character.image,
              width: size.width * 0.3,
              height: size.width * 0.3,
            ),
          ),
          _CharacterInfo(character: character),
        ],
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
    return Flexible(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(character.name),
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
                Flexible(
                  child: Text(
                    '${character.status.capitalized} - ${character.species}',
                  ),
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
