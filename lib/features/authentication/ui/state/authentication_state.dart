import 'package:flutter_mvvm_riverpod/features/authentication/model/auth_res.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_state.freezed.dart';

part 'authentication_state.g.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    @JsonKey(toJson: _authResponseToJson, fromJson: _authResponseFromJson) AuthRes? authResponse,
    @Default(false) bool isAuthenticated,
  }) = _AuthenticationState;

  factory AuthenticationState.fromJson(Map<String, Object?> json) => _$AuthenticationStateFromJson(json);
}

AuthRes? _authResponseFromJson(Map<String, dynamic>? json) {
  return json == null ? null : AuthRes.fromJson(json);
}

Map<String, dynamic>? _authResponseToJson(AuthRes? instance) {
  if (instance == null) return null;
  return {
    'access_token': instance.accessToken,
    'token_type': instance.tokenType,
  };
}
