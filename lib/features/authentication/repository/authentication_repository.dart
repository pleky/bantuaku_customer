import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '/constants/constants.dart';
import '/environment/env.dart';
import '/main.dart';

part 'authentication_repository.g.dart';

@riverpod
AuthenticationRepository authenticationRepository(Ref ref) {
  return AuthenticationRepository();
}

class AuthenticationRepository {
  const AuthenticationRepository();

  Future<void> signInWithMagicLink(String email) async {
    // TODO: fake data
    return;
  }

  Future<AuthResponse> verifyOtp({
    required String email,
    required String token,
    required bool isRegister,
  }) async {
    try {
      // TODO: fake data
      return AuthResponse(
        user: User(
          id: '',
          appMetadata: {},
          userMetadata: {},
          aud: '',
          createdAt: '',
          email: email,
        ),
      );
    } on AuthException catch (error) {
      throw Exception(error.message);
    } catch (error) {
      throw Exception();
    }
  }

  Future<AuthResponse> signInWithGoogle() async {
    // TODO: fake data
    return AuthResponse(
      user: User(
        id: '',
        appMetadata: {},
        userMetadata: {},
        aud: '',
        createdAt: '',
        email: 'henry@google.com',
      ),
    );
  }

  Future<AuthResponse> signInWithApple() async {
    // TODO: fake data
    return AuthResponse(
      user: User(
        id: '',
        appMetadata: {},
        userMetadata: {},
        aud: '',
        createdAt: '',
        email: 'henry@apple.com',
      ),
    );
  }

  Future<void> signOut() async {
    // TODO: fake data
    setIsLogin(false);
    return;
  }

  Future<bool> isLogin() async {
    // TODO: fake data, remove this when integrating real auth
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.isLoginKey) ?? false;
    // END TODO
  }

  // TODO: remove this when integrating real auth
  Future<void> setIsLogin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.isLoginKey, value);
  }

  Future<bool> isExistAccount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.isExistAccountKey) ?? false;
  }

  Future<void> setIsExistAccount(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.isExistAccountKey, value);
  }
  // END TODO
}
