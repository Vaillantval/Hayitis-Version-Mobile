import 'package:freezed_annotation/freezed_annotation.dart';
part 'slider.freezed.dart';
part 'slider.g.dart';

@freezed
class HeroSlide with _$HeroSlide {
  const factory HeroSlide({
    required int id,
    required String title,
    required String description,
    @JsonKey(name: 'button_text') required String buttonText,
    @JsonKey(name: 'button_link') required String buttonLink,
    required String image,
  }) = _HeroSlide;
  factory HeroSlide.fromJson(Map<String, dynamic> json) => _$HeroSlideFromJson(json);
}
