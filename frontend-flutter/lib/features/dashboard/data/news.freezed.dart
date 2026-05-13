// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

News _$NewsFromJson(Map<String, dynamic> json) {
  return _News.fromJson(json);
}

/// @nodoc
mixin _$News {
  int get id => throw _privateConstructorUsedError;

  /// Titre (max 200 chars côté backend)
  String get title => throw _privateConstructorUsedError;

  /// Contenu complet de la news (TEXT côté backend)
  String get content => throw _privateConstructorUsedError;

  /// Auteur (null si supprimé)
  int? get authorId => throw _privateConstructorUsedError;
  String? get authorName => throw _privateConstructorUsedError;

  /// URL image optionnelle (anticipation V2)
  String? get imageUrl => throw _privateConstructorUsedError;

  /// News épinglée sur l'écran d'accueil (max 2 simultanément)
  bool get pinned => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewsCopyWith<News> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsCopyWith<$Res> {
  factory $NewsCopyWith(News value, $Res Function(News) then) =
      _$NewsCopyWithImpl<$Res, News>;
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      int? authorId,
      String? authorName,
      String? imageUrl,
      bool pinned,
      DateTime? createdAt,
      bool active});
}

/// @nodoc
class _$NewsCopyWithImpl<$Res, $Val extends News>
    implements $NewsCopyWith<$Res> {
  _$NewsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? authorId = freezed,
    Object? authorName = freezed,
    Object? imageUrl = freezed,
    Object? pinned = null,
    Object? createdAt = freezed,
    Object? active = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as int?,
      authorName: freezed == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      pinned: null == pinned
          ? _value.pinned
          : pinned // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsImplCopyWith<$Res> implements $NewsCopyWith<$Res> {
  factory _$$NewsImplCopyWith(
          _$NewsImpl value, $Res Function(_$NewsImpl) then) =
      __$$NewsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      int? authorId,
      String? authorName,
      String? imageUrl,
      bool pinned,
      DateTime? createdAt,
      bool active});
}

/// @nodoc
class __$$NewsImplCopyWithImpl<$Res>
    extends _$NewsCopyWithImpl<$Res, _$NewsImpl>
    implements _$$NewsImplCopyWith<$Res> {
  __$$NewsImplCopyWithImpl(_$NewsImpl _value, $Res Function(_$NewsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? authorId = freezed,
    Object? authorName = freezed,
    Object? imageUrl = freezed,
    Object? pinned = null,
    Object? createdAt = freezed,
    Object? active = null,
  }) {
    return _then(_$NewsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as int?,
      authorName: freezed == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      pinned: null == pinned
          ? _value.pinned
          : pinned // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsImpl extends _News {
  const _$NewsImpl(
      {required this.id,
      required this.title,
      required this.content,
      this.authorId,
      this.authorName,
      this.imageUrl,
      this.pinned = false,
      this.createdAt,
      this.active = true})
      : super._();

  factory _$NewsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsImplFromJson(json);

  @override
  final int id;

  /// Titre (max 200 chars côté backend)
  @override
  final String title;

  /// Contenu complet de la news (TEXT côté backend)
  @override
  final String content;

  /// Auteur (null si supprimé)
  @override
  final int? authorId;
  @override
  final String? authorName;

  /// URL image optionnelle (anticipation V2)
  @override
  final String? imageUrl;

  /// News épinglée sur l'écran d'accueil (max 2 simultanément)
  @override
  @JsonKey()
  final bool pinned;
  @override
  final DateTime? createdAt;
  @override
  @JsonKey()
  final bool active;

  @override
  String toString() {
    return 'News(id: $id, title: $title, content: $content, authorId: $authorId, authorName: $authorName, imageUrl: $imageUrl, pinned: $pinned, createdAt: $createdAt, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.pinned, pinned) || other.pinned == pinned) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, content, authorId,
      authorName, imageUrl, pinned, createdAt, active);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsImplCopyWith<_$NewsImpl> get copyWith =>
      __$$NewsImplCopyWithImpl<_$NewsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsImplToJson(
      this,
    );
  }
}

abstract class _News extends News {
  const factory _News(
      {required final int id,
      required final String title,
      required final String content,
      final int? authorId,
      final String? authorName,
      final String? imageUrl,
      final bool pinned,
      final DateTime? createdAt,
      final bool active}) = _$NewsImpl;
  const _News._() : super._();

  factory _News.fromJson(Map<String, dynamic> json) = _$NewsImpl.fromJson;

  @override
  int get id;
  @override

  /// Titre (max 200 chars côté backend)
  String get title;
  @override

  /// Contenu complet de la news (TEXT côté backend)
  String get content;
  @override

  /// Auteur (null si supprimé)
  int? get authorId;
  @override
  String? get authorName;
  @override

  /// URL image optionnelle (anticipation V2)
  String? get imageUrl;
  @override

  /// News épinglée sur l'écran d'accueil (max 2 simultanément)
  bool get pinned;
  @override
  DateTime? get createdAt;
  @override
  bool get active;
  @override
  @JsonKey(ignore: true)
  _$$NewsImplCopyWith<_$NewsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NewsCreateRequest _$NewsCreateRequestFromJson(Map<String, dynamic> json) {
  return _NewsCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$NewsCreateRequest {
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  bool get pinned => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewsCreateRequestCopyWith<NewsCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsCreateRequestCopyWith<$Res> {
  factory $NewsCreateRequestCopyWith(
          NewsCreateRequest value, $Res Function(NewsCreateRequest) then) =
      _$NewsCreateRequestCopyWithImpl<$Res, NewsCreateRequest>;
  @useResult
  $Res call({String title, String content, String? imageUrl, bool pinned});
}

/// @nodoc
class _$NewsCreateRequestCopyWithImpl<$Res, $Val extends NewsCreateRequest>
    implements $NewsCreateRequestCopyWith<$Res> {
  _$NewsCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? pinned = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      pinned: null == pinned
          ? _value.pinned
          : pinned // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsCreateRequestImplCopyWith<$Res>
    implements $NewsCreateRequestCopyWith<$Res> {
  factory _$$NewsCreateRequestImplCopyWith(_$NewsCreateRequestImpl value,
          $Res Function(_$NewsCreateRequestImpl) then) =
      __$$NewsCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String content, String? imageUrl, bool pinned});
}

/// @nodoc
class __$$NewsCreateRequestImplCopyWithImpl<$Res>
    extends _$NewsCreateRequestCopyWithImpl<$Res, _$NewsCreateRequestImpl>
    implements _$$NewsCreateRequestImplCopyWith<$Res> {
  __$$NewsCreateRequestImplCopyWithImpl(_$NewsCreateRequestImpl _value,
      $Res Function(_$NewsCreateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? pinned = null,
  }) {
    return _then(_$NewsCreateRequestImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      pinned: null == pinned
          ? _value.pinned
          : pinned // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsCreateRequestImpl implements _NewsCreateRequest {
  const _$NewsCreateRequestImpl(
      {required this.title,
      required this.content,
      this.imageUrl,
      this.pinned = false});

  factory _$NewsCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsCreateRequestImplFromJson(json);

  @override
  final String title;
  @override
  final String content;
  @override
  final String? imageUrl;
  @override
  @JsonKey()
  final bool pinned;

  @override
  String toString() {
    return 'NewsCreateRequest(title: $title, content: $content, imageUrl: $imageUrl, pinned: $pinned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsCreateRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.pinned, pinned) || other.pinned == pinned));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, content, imageUrl, pinned);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsCreateRequestImplCopyWith<_$NewsCreateRequestImpl> get copyWith =>
      __$$NewsCreateRequestImplCopyWithImpl<_$NewsCreateRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsCreateRequestImplToJson(
      this,
    );
  }
}

abstract class _NewsCreateRequest implements NewsCreateRequest {
  const factory _NewsCreateRequest(
      {required final String title,
      required final String content,
      final String? imageUrl,
      final bool pinned}) = _$NewsCreateRequestImpl;

  factory _NewsCreateRequest.fromJson(Map<String, dynamic> json) =
      _$NewsCreateRequestImpl.fromJson;

  @override
  String get title;
  @override
  String get content;
  @override
  String? get imageUrl;
  @override
  bool get pinned;
  @override
  @JsonKey(ignore: true)
  _$$NewsCreateRequestImplCopyWith<_$NewsCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
