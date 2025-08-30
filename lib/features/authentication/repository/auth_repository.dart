import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mvvm_riverpod/constants/constants.dart';
import 'package:flutter_mvvm_riverpod/features/authentication/model/auth_res.dart';
import 'package:flutter_mvvm_riverpod/features/authentication/model/signin_request.dart';
import 'package:flutter_mvvm_riverpod/features/authentication/model/signup_request.dart';
import 'package:flutter_mvvm_riverpod/features/common/remote/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRepository(apiClient);
}

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<AuthRes> signup(SignupRequest payload) async {
    try {
      final response = await apiClient.post<Map<String, dynamic>>(
        '/register',
        data: payload.toJson(),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return AuthRes.fromJson(response);
    } on BadRequestException catch (e) {
      debugPrint('${Constants.tag} [AuthRepository.signup] BadRequestExceptions: ${e.message}}');
      throw e.message;
    } catch (e) {
      debugPrint('${Constants.tag} [AuthRepository.signup] ERROR: $e');
      throw Exception('Unexpected error occurred during signup');
    }
  }

  Future<AuthRes> signIn(SigninRequest payload) async {
    try {
      final response = await apiClient.post<Map<String, dynamic>>(
        '/login',
        data: payload.toJson(),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return AuthRes.fromJson(response);
    } on BadRequestException catch (e) {
      debugPrint('${Constants.tag} [AuthRepository.signin] BadRequestExceptions: ${e.message}}');
      throw e.message;
    } catch (e) {
      debugPrint('${Constants.tag} [AuthRepository.signin] ERROR: $e');
      throw Exception('Unexpected error occurred during sign-in');
    }
  }

  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.isLoginKey) ?? false;
  }

  Future<void> setLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.isLoginKey, status);
  }

  Future<void> setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.accessKey, token);
  }
}
