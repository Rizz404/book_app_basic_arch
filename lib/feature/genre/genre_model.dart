import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genre_model.g.dart'; // * Generated file untuk serialization

@JsonSerializable() // * Anotasi untuk auto-generate JSON code
class GenreModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GenreModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  // * Factory method untuk parsing dari JSON
  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  // * Method untuk convert ke JSON
  Map<String, dynamic> toJson() => _$GenreModelToJson(this);

  // * Override props untuk Equatable
  @override
  List<Object?> get props => [id, name, description, createdAt, updatedAt];
}

@JsonSerializable()
class CreateGenreModel extends Equatable {
  final String name;
  final String description;

  const CreateGenreModel({
    required this.name,
    required this.description,
  });

  // * JSON Serialization
  factory CreateGenreModel.fromJson(Map<String, dynamic> json) =>
      _$CreateGenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGenreModelToJson(this);

  @override
  List<Object?> get props => [name, description];
}

@JsonSerializable()
class UpdateGenreModel extends Equatable {
  final String id;
  final String? name;
  final String? description;

  const UpdateGenreModel({
    required this.id,
    this.name,
    this.description,
  });

  // * JSON Serialization
  factory UpdateGenreModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateGenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateGenreModelToJson(this);

  @override
  List<Object?> get props => [id, name, description];
}
