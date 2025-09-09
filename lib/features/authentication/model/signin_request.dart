import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_request.g.dart';
part 'signin_request.freezed.dart';

@freezed
abstract class SigninRequest with _$SigninRequest {
  const factory SigninRequest({
    required String email,
    required String password,
    required String role,
    @JsonKey(name: 'fcm_token') required String fcmToken,
  }) = _SigninRequest;

  factory SigninRequest.fromJson(Map<String, dynamic> json) => _$SigninRequestFromJson(json);
}
