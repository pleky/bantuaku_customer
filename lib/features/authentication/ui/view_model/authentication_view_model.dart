import 'package:flutter_mvvm_riverpod/features/authentication/model/auth_res.dart';
import 'package:flutter_mvvm_riverpod/features/authentication/model/signin_request.dart';
import 'package:flutter_mvvm_riverpod/features/authentication/model/signup_request.dart';
import 'package:flutter_mvvm_riverpod/features/authentication/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../ui/state/authentication_state.dart';

part 'authentication_view_model.g.dart';

@riverpod
class AuthenticationViewModel extends _$AuthenticationViewModel {
  @override
  FutureOr<AuthenticationState> build() async {
    return const AuthenticationState();
  }

  Future<void> signUp(SignupRequest signupRequest) async {
    state = const AsyncValue.loading();
    final authRepo = ref.read(authRepositoryProvider);
    final result = await AsyncValue.guard(() => authRepo.signup(signupRequest));

    handleResult(result);
  }

  Future<void> signIn(SigninRequest signinRequest) async {
    state = const AsyncValue.loading();
    final authRepo = ref.read(authRepositoryProvider);
    final result = await AsyncValue.guard(() => authRepo.signIn(signinRequest));

    handleResult(result);
  }

  void handleResult(AsyncValue result) async {
    if (result is AsyncError) {
      state = AsyncError(result.error.toString(), StackTrace.current);
      return;
    }

    final AuthRes? authResponse = result.value;

    state = AsyncData(
      AuthenticationState(
        authResponse: authResponse,
        isAuthenticated: true,
      ),
    );
    ref.read(authRepositoryProvider).setAccessToken(authResponse!.accessToken);
    ref.read(authRepositoryProvider).setLoginStatus(true);
  }
}

// @riverpod
// class AuthenticationViewModel extends _$AuthenticationViewModel {
//   @override
//   FutureOr<AuthenticationState> build() async {
//     return const AuthenticationState();
//   }

//   Future<void> signInWithMagicLink(String email) async {
//     state = const AsyncValue.loading();
//     final authRepo = ref.read(authenticationRepositoryProvider);
//     final result =
//         await AsyncValue.guard(() => authRepo.signInWithMagicLink(email));

//     if (result is AsyncError) {
//       state = AsyncError(result.error.toString(), StackTrace.current);
//       return;
//     }

//     state = const AsyncData(AuthenticationState());
//   }

//   Future<void> verifyOtp({
//     required String email,
//     required String token,
//     required bool isRegister,
//   }) async {
//     state = const AsyncValue.loading();
//     final authRepo = ref.read(authenticationRepositoryProvider);
//     final result = await AsyncValue.guard(
//       () => authRepo.verifyOtp(
//         email: email,
//         token: token,
//         isRegister: isRegister,
//       ),
//     );
//     handleResult(result);
//   }

//   Future<void> signInWithGoogle() async {
//     state = const AsyncValue.loading();
//     final authRepo = ref.read(authenticationRepositoryProvider);
//     final result = await AsyncValue.guard(authRepo.signInWithGoogle);
//     handleResult(result);
//   }

//   Future<void> signInWithApple() async {
//     state = const AsyncValue.loading();
//     final authRepo = ref.read(authenticationRepositoryProvider);
//     final result = await AsyncValue.guard(authRepo.signInWithApple);
//     handleResult(result);
//   }

//   Future<void> signOut() async {
//     state = const AsyncValue.loading();
//     final authRepo = ref.read(authenticationRepositoryProvider);
//     final result = await AsyncValue.guard(authRepo.signOut);

//     if (result is AsyncError) {
//       state = AsyncError(result.error.toString(), StackTrace.current);
//       return;
//     }

//     state = const AsyncData(AuthenticationState());
//   }

  // void handleResult(AsyncValue result) async {
  //   debugPrint(
  //       '${Constants.tag} [AuthenticationViewModel.handleResult] result: $result');
  //   if (result is AsyncError) {
  //     state = AsyncError(result.error.toString(), StackTrace.current);
  //     return;
  //   }

  //   final AuthResponse? authResponse = result.value;
  //   debugPrint(
  //       '${Constants.tag} [AuthenticationViewModel.handleResult] authResponse: ${authResponse?.user?.toJson()}');
  //   if (authResponse == null) {
  //     state = AsyncError('unexpected_error_occurred'.tr(), StackTrace.current);
  //     return;
  //   }

  //   final isExistAccount =
  //       await ref.read(authenticationRepositoryProvider).isExistAccount();
  //   if (!isExistAccount) {
  //     ref.read(authenticationRepositoryProvider).setIsExistAccount(true);
  //   }

  //   String? name;
  //   String? avatar;
  //   final metaData = authResponse.user?.userMetadata;
  //   if (metaData != null) {
  //     name = metaData['full_name'];
  //     avatar = metaData['avatar_url'];
  //   }
  //   ref.read(authenticationRepositoryProvider).setIsLogin(true);
  //   ref.read(profileViewModelProvider.notifier).updateProfile(
  //         email: authResponse.user?.email.orEmpty(),
  //         name: name,
  //         avatar: avatar,
  //       );

  //   state = AsyncData(
  //     AuthenticationState(
  //       authResponse: authResponse,
  //       isRegisterSuccessfully: !isExistAccount,
  //       isSignInSuccessfully: true,
  //     ),
  //   );
  // }
// }
