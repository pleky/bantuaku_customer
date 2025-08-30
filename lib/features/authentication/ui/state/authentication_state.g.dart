// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthenticationState _$AuthenticationStateFromJson(Map<String, dynamic> json) =>
    _AuthenticationState(
      authResponse:
          _authResponseFromJson(json['authResponse'] as Map<String, dynamic>?),
      isAuthenticated: json['isAuthenticated'] as bool? ?? false,
    );

Map<String, dynamic> _$AuthenticationStateToJson(
        _AuthenticationState instance) =>
    <String, dynamic>{
      'authResponse': _authResponseToJson(instance.authResponse),
      'isAuthenticated': instance.isAuthenticated,
    };
