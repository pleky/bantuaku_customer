// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileState _$ProfileStateFromJson(Map<String, dynamic> json) =>
    _ProfileState(
      profile: json['profile'] == null
          ? null
          : UserModel.fromJson(json['profile'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$ProfileStateToJson(_ProfileState instance) =>
    <String, dynamic>{
      'profile': instance.profile,
      'isLoading': instance.isLoading,
      'errorMessage': instance.errorMessage,
    };
