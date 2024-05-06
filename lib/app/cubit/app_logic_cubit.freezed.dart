// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_logic_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppLogicState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool darkMode) isDarkMode,
    required TResult Function(bool isEnglish) isLanguageEnglish,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(bool darkMode)? isDarkMode,
    TResult? Function(bool isEnglish)? isLanguageEnglish,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool darkMode)? isDarkMode,
    TResult Function(bool isEnglish)? isLanguageEnglish,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(IsDark value) isDarkMode,
    required TResult Function(IsEnglish value) isLanguageEnglish,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(IsDark value)? isDarkMode,
    TResult? Function(IsEnglish value)? isLanguageEnglish,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(IsDark value)? isDarkMode,
    TResult Function(IsEnglish value)? isLanguageEnglish,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppLogicStateCopyWith<$Res> {
  factory $AppLogicStateCopyWith(
          AppLogicState value, $Res Function(AppLogicState) then) =
      _$AppLogicStateCopyWithImpl<$Res, AppLogicState>;
}

/// @nodoc
class _$AppLogicStateCopyWithImpl<$Res, $Val extends AppLogicState>
    implements $AppLogicStateCopyWith<$Res> {
  _$AppLogicStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AppLogicStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AppLogicState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool darkMode) isDarkMode,
    required TResult Function(bool isEnglish) isLanguageEnglish,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(bool darkMode)? isDarkMode,
    TResult? Function(bool isEnglish)? isLanguageEnglish,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool darkMode)? isDarkMode,
    TResult Function(bool isEnglish)? isLanguageEnglish,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(IsDark value) isDarkMode,
    required TResult Function(IsEnglish value) isLanguageEnglish,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(IsDark value)? isDarkMode,
    TResult? Function(IsEnglish value)? isLanguageEnglish,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(IsDark value)? isDarkMode,
    TResult Function(IsEnglish value)? isLanguageEnglish,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AppLogicState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$IsDarkImplCopyWith<$Res> {
  factory _$$IsDarkImplCopyWith(
          _$IsDarkImpl value, $Res Function(_$IsDarkImpl) then) =
      __$$IsDarkImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool darkMode});
}

/// @nodoc
class __$$IsDarkImplCopyWithImpl<$Res>
    extends _$AppLogicStateCopyWithImpl<$Res, _$IsDarkImpl>
    implements _$$IsDarkImplCopyWith<$Res> {
  __$$IsDarkImplCopyWithImpl(
      _$IsDarkImpl _value, $Res Function(_$IsDarkImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? darkMode = null,
  }) {
    return _then(_$IsDarkImpl(
      null == darkMode
          ? _value.darkMode
          : darkMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$IsDarkImpl implements IsDark {
  const _$IsDarkImpl(this.darkMode);

  @override
  final bool darkMode;

  @override
  String toString() {
    return 'AppLogicState.isDarkMode(darkMode: $darkMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IsDarkImpl &&
            (identical(other.darkMode, darkMode) ||
                other.darkMode == darkMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, darkMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IsDarkImplCopyWith<_$IsDarkImpl> get copyWith =>
      __$$IsDarkImplCopyWithImpl<_$IsDarkImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool darkMode) isDarkMode,
    required TResult Function(bool isEnglish) isLanguageEnglish,
  }) {
    return isDarkMode(darkMode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(bool darkMode)? isDarkMode,
    TResult? Function(bool isEnglish)? isLanguageEnglish,
  }) {
    return isDarkMode?.call(darkMode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool darkMode)? isDarkMode,
    TResult Function(bool isEnglish)? isLanguageEnglish,
    required TResult orElse(),
  }) {
    if (isDarkMode != null) {
      return isDarkMode(darkMode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(IsDark value) isDarkMode,
    required TResult Function(IsEnglish value) isLanguageEnglish,
  }) {
    return isDarkMode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(IsDark value)? isDarkMode,
    TResult? Function(IsEnglish value)? isLanguageEnglish,
  }) {
    return isDarkMode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(IsDark value)? isDarkMode,
    TResult Function(IsEnglish value)? isLanguageEnglish,
    required TResult orElse(),
  }) {
    if (isDarkMode != null) {
      return isDarkMode(this);
    }
    return orElse();
  }
}

abstract class IsDark implements AppLogicState {
  const factory IsDark(final bool darkMode) = _$IsDarkImpl;

  bool get darkMode;
  @JsonKey(ignore: true)
  _$$IsDarkImplCopyWith<_$IsDarkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$IsEnglishImplCopyWith<$Res> {
  factory _$$IsEnglishImplCopyWith(
          _$IsEnglishImpl value, $Res Function(_$IsEnglishImpl) then) =
      __$$IsEnglishImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isEnglish});
}

/// @nodoc
class __$$IsEnglishImplCopyWithImpl<$Res>
    extends _$AppLogicStateCopyWithImpl<$Res, _$IsEnglishImpl>
    implements _$$IsEnglishImplCopyWith<$Res> {
  __$$IsEnglishImplCopyWithImpl(
      _$IsEnglishImpl _value, $Res Function(_$IsEnglishImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnglish = null,
  }) {
    return _then(_$IsEnglishImpl(
      null == isEnglish
          ? _value.isEnglish
          : isEnglish // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$IsEnglishImpl implements IsEnglish {
  const _$IsEnglishImpl(this.isEnglish);

  @override
  final bool isEnglish;

  @override
  String toString() {
    return 'AppLogicState.isLanguageEnglish(isEnglish: $isEnglish)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IsEnglishImpl &&
            (identical(other.isEnglish, isEnglish) ||
                other.isEnglish == isEnglish));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEnglish);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IsEnglishImplCopyWith<_$IsEnglishImpl> get copyWith =>
      __$$IsEnglishImplCopyWithImpl<_$IsEnglishImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(bool darkMode) isDarkMode,
    required TResult Function(bool isEnglish) isLanguageEnglish,
  }) {
    return isLanguageEnglish(isEnglish);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(bool darkMode)? isDarkMode,
    TResult? Function(bool isEnglish)? isLanguageEnglish,
  }) {
    return isLanguageEnglish?.call(isEnglish);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(bool darkMode)? isDarkMode,
    TResult Function(bool isEnglish)? isLanguageEnglish,
    required TResult orElse(),
  }) {
    if (isLanguageEnglish != null) {
      return isLanguageEnglish(isEnglish);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(IsDark value) isDarkMode,
    required TResult Function(IsEnglish value) isLanguageEnglish,
  }) {
    return isLanguageEnglish(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(IsDark value)? isDarkMode,
    TResult? Function(IsEnglish value)? isLanguageEnglish,
  }) {
    return isLanguageEnglish?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(IsDark value)? isDarkMode,
    TResult Function(IsEnglish value)? isLanguageEnglish,
    required TResult orElse(),
  }) {
    if (isLanguageEnglish != null) {
      return isLanguageEnglish(this);
    }
    return orElse();
  }
}

abstract class IsEnglish implements AppLogicState {
  const factory IsEnglish(final bool isEnglish) = _$IsEnglishImpl;

  bool get isEnglish;
  @JsonKey(ignore: true)
  _$$IsEnglishImplCopyWith<_$IsEnglishImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
