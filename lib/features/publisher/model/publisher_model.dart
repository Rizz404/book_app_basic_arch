import 'package:freezed_annotation/freezed_annotation.dart';

part 'publisher_model.freezed.dart';
part 'publisher_model.g.dart';

@freezed
class PublisherModel with _$PublisherModel {
  const factory PublisherModel({
    required String id,
    required String name,
    required String email,
    required String description,
    required List<String> website,
    required String picture,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int followerCount,
    @Default(false) bool isFollowedPublisher,
    @Default(false) bool originalFollowStatus,
  }) = _PublisherModel;

  factory PublisherModel.fromJson(Map<String, dynamic> json) =>
      _$PublisherModelFromJson(json);
}

@freezed
class CreatePublisherModel with _$CreatePublisherModel {
  const factory CreatePublisherModel({
    required String name,
    required String email,
    required String description,
    required List<String> website,
    required String picture,
  }) = _CreatePublisherModel;

  factory CreatePublisherModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePublisherModelFromJson(json);
}

@freezed
class UpdatePublisherModel with _$UpdatePublisherModel {
  const factory UpdatePublisherModel({
    required String id,
    String? name,
    String? email,
    String? description,
    List<String>? website,
    String? picture,
  }) = _UpdatePublisherModel;

  factory UpdatePublisherModel.fromJson(Map<String, dynamic> json) =>
      _$UpdatePublisherModelFromJson(json);
}
