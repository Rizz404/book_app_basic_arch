import 'package:freezed_annotation/freezed_annotation.dart';

part 'publisher_filter_model.freezed.dart';
part 'publisher_filter_model.g.dart';

@freezed
class PublisherFilterModel with _$PublisherFilterModel {
  const factory PublisherFilterModel({
    @Default(1) int page,
    @Default(10) int limit,
  }) = _PublisherFilterModel;

  factory PublisherFilterModel.fromJson(Map<String, dynamic> json) =>
      _$PublisherFilterModelFromJson(json);
}
