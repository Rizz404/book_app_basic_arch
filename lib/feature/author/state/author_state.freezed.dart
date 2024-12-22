// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'author_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthorState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthorOperation operation) loading,
    required TResult Function(AuthorOperation operation, T data) response,
    required TResult Function(AuthorOperation operation, String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthorOperation operation)? loading,
    TResult? Function(AuthorOperation operation, T data)? response,
    TResult? Function(AuthorOperation operation, String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthorOperation operation)? loading,
    TResult Function(AuthorOperation operation, T data)? response,
    TResult Function(AuthorOperation operation, String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle<T> value) idle,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Response<T> value) response,
    required TResult Function(_Error<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle<T> value)? idle,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Response<T> value)? response,
    TResult? Function(_Error<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle<T> value)? idle,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Response<T> value)? response,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorStateCopyWith<T, $Res> {
  factory $AuthorStateCopyWith(
          AuthorState<T> value, $Res Function(AuthorState<T>) then) =
      _$AuthorStateCopyWithImpl<T, $Res, AuthorState<T>>;
}

/// @nodoc
class _$AuthorStateCopyWithImpl<T, $Res, $Val extends AuthorState<T>>
    implements $AuthorStateCopyWith<T, $Res> {
  _$AuthorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$IdleImplCopyWith<T, $Res> {
  factory _$$IdleImplCopyWith(
          _$IdleImpl<T> value, $Res Function(_$IdleImpl<T>) then) =
      __$$IdleImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$IdleImplCopyWithImpl<T, $Res>
    extends _$AuthorStateCopyWithImpl<T, $Res, _$IdleImpl<T>>
    implements _$$IdleImplCopyWith<T, $Res> {
  __$$IdleImplCopyWithImpl(
      _$IdleImpl<T> _value, $Res Function(_$IdleImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IdleImpl<T> implements _Idle<T> {
  const _$IdleImpl();

  @override
  String toString() {
    return 'AuthorState<$T>.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthorOperation operation) loading,
    required TResult Function(AuthorOperation operation, T data) response,
    required TResult Function(AuthorOperation operation, String message) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthorOperation operation)? loading,
    TResult? Function(AuthorOperation operation, T data)? response,
    TResult? Function(AuthorOperation operation, String message)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthorOperation operation)? loading,
    TResult Function(AuthorOperation operation, T data)? response,
    TResult Function(AuthorOperation operation, String message)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle<T> value) idle,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Response<T> value) response,
    required TResult Function(_Error<T> value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle<T> value)? idle,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Response<T> value)? response,
    TResult? Function(_Error<T> value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle<T> value)? idle,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Response<T> value)? response,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle<T> implements AuthorState<T> {
  const factory _Idle() = _$IdleImpl<T>;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<T, $Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl<T> value, $Res Function(_$LoadingImpl<T>) then) =
      __$$LoadingImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({AuthorOperation operation});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<T, $Res>
    extends _$AuthorStateCopyWithImpl<T, $Res, _$LoadingImpl<T>>
    implements _$$LoadingImplCopyWith<T, $Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl<T> _value, $Res Function(_$LoadingImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operation = null,
  }) {
    return _then(_$LoadingImpl<T>(
      operation: null == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as AuthorOperation,
    ));
  }
}

/// @nodoc

class _$LoadingImpl<T> implements _Loading<T> {
  const _$LoadingImpl({required this.operation});

  @override
  final AuthorOperation operation;

  @override
  String toString() {
    return 'AuthorState<$T>.loading(operation: $operation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl<T> &&
            (identical(other.operation, operation) ||
                other.operation == operation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, operation);

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<T, _$LoadingImpl<T>> get copyWith =>
      __$$LoadingImplCopyWithImpl<T, _$LoadingImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthorOperation operation) loading,
    required TResult Function(AuthorOperation operation, T data) response,
    required TResult Function(AuthorOperation operation, String message) error,
  }) {
    return loading(operation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthorOperation operation)? loading,
    TResult? Function(AuthorOperation operation, T data)? response,
    TResult? Function(AuthorOperation operation, String message)? error,
  }) {
    return loading?.call(operation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthorOperation operation)? loading,
    TResult Function(AuthorOperation operation, T data)? response,
    TResult Function(AuthorOperation operation, String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(operation);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle<T> value) idle,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Response<T> value) response,
    required TResult Function(_Error<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle<T> value)? idle,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Response<T> value)? response,
    TResult? Function(_Error<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle<T> value)? idle,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Response<T> value)? response,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading<T> implements AuthorState<T> {
  const factory _Loading({required final AuthorOperation operation}) =
      _$LoadingImpl<T>;

  AuthorOperation get operation;

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<T, _$LoadingImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResponseImplCopyWith<T, $Res> {
  factory _$$ResponseImplCopyWith(
          _$ResponseImpl<T> value, $Res Function(_$ResponseImpl<T>) then) =
      __$$ResponseImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({AuthorOperation operation, T data});
}

/// @nodoc
class __$$ResponseImplCopyWithImpl<T, $Res>
    extends _$AuthorStateCopyWithImpl<T, $Res, _$ResponseImpl<T>>
    implements _$$ResponseImplCopyWith<T, $Res> {
  __$$ResponseImplCopyWithImpl(
      _$ResponseImpl<T> _value, $Res Function(_$ResponseImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operation = null,
    Object? data = freezed,
  }) {
    return _then(_$ResponseImpl<T>(
      operation: null == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as AuthorOperation,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$ResponseImpl<T> implements _Response<T> {
  const _$ResponseImpl({required this.operation, required this.data});

  @override
  final AuthorOperation operation;
  @override
  final T data;

  @override
  String toString() {
    return 'AuthorState<$T>.response(operation: $operation, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseImpl<T> &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, operation, const DeepCollectionEquality().hash(data));

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseImplCopyWith<T, _$ResponseImpl<T>> get copyWith =>
      __$$ResponseImplCopyWithImpl<T, _$ResponseImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthorOperation operation) loading,
    required TResult Function(AuthorOperation operation, T data) response,
    required TResult Function(AuthorOperation operation, String message) error,
  }) {
    return response(operation, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthorOperation operation)? loading,
    TResult? Function(AuthorOperation operation, T data)? response,
    TResult? Function(AuthorOperation operation, String message)? error,
  }) {
    return response?.call(operation, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthorOperation operation)? loading,
    TResult Function(AuthorOperation operation, T data)? response,
    TResult Function(AuthorOperation operation, String message)? error,
    required TResult orElse(),
  }) {
    if (response != null) {
      return response(operation, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle<T> value) idle,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Response<T> value) response,
    required TResult Function(_Error<T> value) error,
  }) {
    return response(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle<T> value)? idle,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Response<T> value)? response,
    TResult? Function(_Error<T> value)? error,
  }) {
    return response?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle<T> value)? idle,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Response<T> value)? response,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (response != null) {
      return response(this);
    }
    return orElse();
  }
}

abstract class _Response<T> implements AuthorState<T> {
  const factory _Response(
      {required final AuthorOperation operation,
      required final T data}) = _$ResponseImpl<T>;

  AuthorOperation get operation;
  T get data;

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResponseImplCopyWith<T, _$ResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<T, $Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl<T> value, $Res Function(_$ErrorImpl<T>) then) =
      __$$ErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({AuthorOperation operation, String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<T, $Res>
    extends _$AuthorStateCopyWithImpl<T, $Res, _$ErrorImpl<T>>
    implements _$$ErrorImplCopyWith<T, $Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl<T> _value, $Res Function(_$ErrorImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? operation = null,
    Object? message = null,
  }) {
    return _then(_$ErrorImpl<T>(
      operation: null == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as AuthorOperation,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl<T> implements _Error<T> {
  const _$ErrorImpl({required this.operation, required this.message});

  @override
  final AuthorOperation operation;
  @override
  final String message;

  @override
  String toString() {
    return 'AuthorState<$T>.error(operation: $operation, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl<T> &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, operation, message);

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      __$$ErrorImplCopyWithImpl<T, _$ErrorImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(AuthorOperation operation) loading,
    required TResult Function(AuthorOperation operation, T data) response,
    required TResult Function(AuthorOperation operation, String message) error,
  }) {
    return error(operation, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(AuthorOperation operation)? loading,
    TResult? Function(AuthorOperation operation, T data)? response,
    TResult? Function(AuthorOperation operation, String message)? error,
  }) {
    return error?.call(operation, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(AuthorOperation operation)? loading,
    TResult Function(AuthorOperation operation, T data)? response,
    TResult Function(AuthorOperation operation, String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(operation, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Idle<T> value) idle,
    required TResult Function(_Loading<T> value) loading,
    required TResult Function(_Response<T> value) response,
    required TResult Function(_Error<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Idle<T> value)? idle,
    TResult? Function(_Loading<T> value)? loading,
    TResult? Function(_Response<T> value)? response,
    TResult? Function(_Error<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Idle<T> value)? idle,
    TResult Function(_Loading<T> value)? loading,
    TResult Function(_Response<T> value)? response,
    TResult Function(_Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error<T> implements AuthorState<T> {
  const factory _Error(
      {required final AuthorOperation operation,
      required final String message}) = _$ErrorImpl<T>;

  AuthorOperation get operation;
  String get message;

  /// Create a copy of AuthorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
