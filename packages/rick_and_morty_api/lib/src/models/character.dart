import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

/// {@template character}
/// Character model.
/// {@endtemplate}
@JsonSerializable(createToJson: false)
class Character extends Equatable {
  /// {@macro character}
  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    required this.url,
  });

  ///
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  /// The id of the character.
  final int id;

  /// The name of the character.
  final String name;

  /// The status of the character. (Alive, Dead, unknown)
  final String status;

  /// The species of the character.
  final String species;

  /// Link to the character's image. All images are 300x300px and most are
  /// medium shots or portraits since they are intended to be used as avatars.
  final String image;

  /// Link to the character's own URL endpoint
  final String url;

  @override
  List<Object> get props => [id, name, status, species, image, url];
}
