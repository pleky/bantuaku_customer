import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../features/profile/repository/profile_repository.dart';
import '../../../../features/profile/ui/state/profile_state.dart';

part 'profile_view_model.g.dart';

@Riverpod(keepAlive: true)
class ProfileViewModel extends _$ProfileViewModel {
  @override
  FutureOr<ProfileState> build() async {
    getUser();

    return future;
  }

  Future<void> getUser() async {
    state = const AsyncValue.loading();
    final repo = ref.read(profileRepositoryProvider);
    final result = await AsyncValue.guard(() => repo.fetchDetailUser());
    handleResult(result);
  }

  Future<void> updateAddress(String address) async {
    state = const AsyncValue.loading();
    final repo = ref.read(profileRepositoryProvider);
    final result = await AsyncValue.guard(() => repo.updateAddress(address));

    if (result.hasError) {
      state = AsyncError(result.error.toString(), StackTrace.current);
      return;
    }

    getUser();
  }

  void handleResult(AsyncValue result) {
    if (result is AsyncError) {
      state = AsyncError(result.error.toString(), StackTrace.current);
      return;
    }

    final user = result.value;

    state = AsyncData(
      ProfileState(profile: user),
    );
  }
}
