// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HeroSlide _$HeroSlideFromJson(Map<String, dynamic> json) {
  return _HeroSlide.fromJson(json);
}

/// @nodoc
mixin _$HeroSlide {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'button_text')
  String get buttonText => throw _privateConstructorUsedError;
  @JsonKey(name: 'button_link')
  String get buttonLink => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  /// Serializes this HeroSlide to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HeroSlide
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HeroSlideCopyWith<HeroSlide> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HeroSlideCopyWith<$Res> {
  factory $HeroSlideCopyWith(HeroSlide value, $Res Function(HeroSlide) then) =
      _$HeroSlideCopyWithImpl<$Res, HeroSlide>;
  @useResult
  $Res call({
    int id,
    String title,
    String description,
    @JsonKey(name: 'button_text') String buttonText,
    @JsonKey(name: 'button_link') String buttonLink,
    String image,
  });
}

/// @nodoc
class _$HeroSlideCopyWithImpl<$Res, $Val extends HeroSlide>
    implements $HeroSlideCopyWith<$Res> {
  _$HeroSlideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HeroSlide
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? buttonText = null,
    Object? buttonLink = null,
    Object? image = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            buttonText:
                null == buttonText
                    ? _value.buttonText
                    : buttonText // ignore: cast_nullable_to_non_nullable
                        as String,
            buttonLink:
                null == buttonLink
                    ? _value.buttonLink
                    : buttonLink // ignore: cast_nullable_to_non_nullable
                        as String,
            image:
                null == image
                    ? _value.image
                    : image // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HeroSlideImplCopyWith<$Res>
    implements $HeroSlideCopyWith<$Res> {
  factory _$$HeroSlideImplCopyWith(
    _$HeroSlideImpl value,
    $Res Function(_$HeroSlideImpl) then,
  ) = __$$HeroSlideImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    String description,
    @JsonKey(name: 'button_text') String buttonText,
    @JsonKey(name: 'button_link') String buttonLink,
    String image,
  });
}

/// @nodoc
class __$$HeroSlideImplCopyWithImpl<$Res>
    extends _$HeroSlideCopyWithImpl<$Res, _$HeroSlideImpl>
    implements _$$HeroSlideImplCopyWith<$Res> {
  __$$HeroSlideImplCopyWithImpl(
    _$HeroSlideImpl _value,
    $Res Function(_$HeroSlideImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HeroSlide
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? buttonText = null,
    Object? buttonLink = null,
    Object? image = null,
  }) {
    return _then(
      _$HeroSlideImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        buttonText:
            null == buttonText
                ? _value.buttonText
                : buttonText // ignore: cast_nullable_to_non_nullable
                    as String,
        buttonLink:
            null == buttonLink
                ? _value.buttonLink
                : buttonLink // ignore: cast_nullable_to_non_nullable
                    as String,
        image:
            null == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HeroSlideImpl implements _HeroSlide {
  const _$HeroSlideImpl({
    required this.id,
    required this.title,
    required this.description,
    @JsonKey(name: 'button_text') required this.buttonText,
    @JsonKey(name: 'button_link') required this.buttonLink,
    required this.image,
  });

  factory _$HeroSlideImpl.fromJson(Map<String, dynamic> json) =>
      _$$HeroSlideImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(name: 'button_text')
  final String buttonText;
  @override
  @JsonKey(name: 'button_link')
  final String buttonLink;
  @override
  final String image;

  @override
  String toString() {
    return 'HeroSlide(id: $id, title: $title, description: $description, buttonText: $buttonText, buttonLink: $buttonLink, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HeroSlideImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.buttonText, buttonText) ||
                other.buttonText == buttonText) &&
            (identical(other.buttonLink, buttonLink) ||
                other.buttonLink == buttonLink) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    buttonText,
    buttonLink,
    image,
  );

  /// Create a copy of HeroSlide
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HeroSlideImplCopyWith<_$HeroSlideImpl> get copyWith =>
      __$$HeroSlideImplCopyWithImpl<_$HeroSlideImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HeroSlideImplToJson(this);
  }
}

abstract class _HeroSlide implements HeroSlide {
  const factory _HeroSlide({
    required final int id,
    required final String title,
    required final String description,
    @JsonKey(name: 'button_text') required final String buttonText,
    @JsonKey(name: 'button_link') required final String buttonLink,
    required final String image,
  }) = _$HeroSlideImpl;

  factory _HeroSlide.fromJson(Map<String, dynamic> json) =
      _$HeroSlideImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'button_text')
  String get buttonText;
  @override
  @JsonKey(name: 'button_link')
  String get buttonLink;
  @override
  String get image;

  /// Create a copy of HeroSlide
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HeroSlideImplCopyWith<_$HeroSlideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
