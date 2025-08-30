import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_request.freezed.dart';
part 'signup_request.g.dart';

@freezed
abstract class SignupRequest with _$SignupRequest {
  const factory SignupRequest({
    required String role,
    required String name,
    required String phone,
    required String address,
    required String email,
    required String password,
    @JsonKey(name: 'password_confirmation') required String passwordConfirmation,
    required String terms,
    @Default('') @JsonKey(name: 'referral_code') String referralCode,
    required String lat,
    required String long,
  }) = _SignupRequest;

  factory SignupRequest.fromJson(Map<String, Object?> json) => _$SignupRequestFromJson(json);
}
