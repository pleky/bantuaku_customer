// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthenticationState {
  @JsonKey(toJson: _authResponseToJson, fromJson: _authResponseFromJson)
  AuthRes? get authResponse;
  bool get isAuthenticated;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthenticationStateCopyWith<AuthenticationState> get copyWith =>
      _$AuthenticationStateCopyWithImpl<AuthenticationState>(
          this as AuthenticationState, _$identity);

  /// Serializes this AuthenticationState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthenticationState &&
            (identical(other.authResponse, authResponse) ||
                other.authResponse == authResponse) &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, authResponse, isAuthenticated);

  @override
  String toString() {
    return 'AuthenticationState(authResponse: $authResponse, isAuthenticated: $isAuthenticated)';
  }
}

/// @nodoc
abstract mixin class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) _then) =
      _$AuthenticationStateCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(toJson: _authResponseToJson, fromJson: _authResponseFromJson)
      AuthRes? authResponse,
      bool isAuthenticated});

  $AuthResCopyWith<$Res>? get authResponse;
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._self, this._then);

  final AuthenticationState _self;
  final $Res Function(AuthenticationState) _then;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authResponse = freezed,
    Object? isAuthenticated = null,
  }) {
    return _then(_self.copyWith(
      authResponse: freezed == authResponse
          ? _self.authResponse
          : authResponse // ignore: cast_nullable_to_non_nullable
              as AuthRes?,
      isAuthenticated: null == isAuthenticated
          ? _self.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthResCopyWith<$Res>? get authResponse {
    if (_self.authResponse == null) {
      return null;
    }

    return $AuthResCopyWith<$Res>(_self.authResponse!, (value) {
      return _then(_self.copyWith(authResponse: value));
    });
  }
}

/// Adds pattern-matching-related methods to [AuthenticationState].
extension AuthenticationStatePatterns on AuthenticationState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AuthenticationState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticationState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AuthenticationState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthenticationState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AuthenticationState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthenticationState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(
                toJson: _authResponseToJson, fromJson: _authResponseFromJson)
            AuthRes? authResponse,
            bool isAuthenticated)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AuthenticationState() when $default != null:
        return $default(_that.authResponse, _that.isAuthenticated);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(
                toJson: _authResponseToJson, fromJson: _authResponseFromJson)
            AuthRes? authResponse,
            bool isAuthenticated)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthenticationState():
        return $default(_that.authResponse, _that.isAuthenticated);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(
                toJson: _authResponseToJson, fromJson: _authResponseFromJson)
            AuthRes? authResponse,
            bool isAuthenticated)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AuthenticationState() when $default != null:
        return $default(_that.authResponse, _that.isAuthenticated);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AuthenticationState implements AuthenticationState {
  const _AuthenticationState(
      {@JsonKey(toJson: _authResponseToJson, fromJson: _authResponseFromJson)
      this.authResponse,
      this.isAuthenticated = false});
  factory _AuthenticationState.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationStateFromJson(json);

  @override
  @JsonKey(toJson: _authResponseToJson, fromJson: _authResponseFromJson)
  final AuthRes? authResponse;
  @override
  @JsonKey()
  final bool isAuthenticated;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthenticationStateCopyWith<_AuthenticationState> get copyWith =>
      __$AuthenticationStateCopyWithImpl<_AuthenticationState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuthenticationStateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthenticationState &&
            (identical(other.authResponse, authResponse) ||
                other.authResponse == authResponse) &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, authResponse, isAuthenticated);

  @override
  String toString() {
    return 'AuthenticationState(authResponse: $authResponse, isAuthenticated: $isAuthenticated)';
  }
}

/// @nodoc
abstract mixin class _$AuthenticationStateCopyWith<$Res>
    implements $AuthenticationStateCopyWith<$Res> {
  factory _$AuthenticationStateCopyWith(_AuthenticationState value,
          $Res Function(_AuthenticationState) _then) =
      __$AuthenticationStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(toJson: _authResponseToJson, fromJson: _authResponseFromJson)
      AuthRes? authResponse,
      bool isAuthenticated});

  @override
  $AuthResCopyWith<$Res>? get authResponse;
}

/// @nodoc
class __$AuthenticationStateCopyWithImpl<$Res>
    implements _$AuthenticationStateCopyWith<$Res> {
  __$AuthenticationStateCopyWithImpl(this._self, this._then);

  final _AuthenticationState _self;
  final $Res Function(_AuthenticationState) _then;

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? authResponse = freezed,
    Object? isAuthenticated = null,
  }) {
    return _then(_AuthenticationState(
      authResponse: freezed == authResponse
          ? _self.authResponse
          : authResponse // ignore: cast_nullable_to_non_nullable
              as AuthRes?,
      isAuthenticated: null == isAuthenticated
          ? _self.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of AuthenticationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthResCopyWith<$Res>? get authResponse {
    if (_self.authResponse == null) {
      return null;
    }

    return $AuthResCopyWith<$Res>(_self.authResponse!, (value) {
      return _then(_self.copyWith(authResponse: value));
    });
  }
}

// dart format on
