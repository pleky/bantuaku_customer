import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_res.g.dart';
part 'auth_res.freezed.dart';

@freezed
abstract class AuthRes with _$AuthRes {
  const factory AuthRes({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'token_type') required String tokenType,
  }) = _AuthRes;
  factory AuthRes.fromJson(Map<String, dynamic> json) => _$AuthResFromJson(json);
}
