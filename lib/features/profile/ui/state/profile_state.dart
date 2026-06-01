import 'package:bantuaku_customer/features/common/model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '/features/profile/model/profile.dart';

part 'profile_state.freezed.dart';
part 'profile_state.g.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    UserModel? profile,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _ProfileState;

  factory ProfileState.fromJson(Map<String, Object?> json) => _$ProfileStateFromJson(json);
}
