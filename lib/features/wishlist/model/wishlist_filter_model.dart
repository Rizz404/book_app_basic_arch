import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_filter_model.freezed.dart';
part 'wishlist_filter_model.g.dart';

@freezed
class WishlistFilterModel with _$WishlistFilterModel {
  const factory WishlistFilterModel({
    @Default(1) int page,
    @Default(10) int limit,
  }) = _WishlistFilterModel;

  factory WishlistFilterModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistFilterModelFromJson(json);
}
