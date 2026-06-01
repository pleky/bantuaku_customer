import 'dart:convert';

import 'package:bantuaku_customer/features/common/model/user_model.dart';
import 'package:bantuaku_customer/features/common/remote/api_client.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constants.dart';
import '../../../features/profile/model/profile.dart';
import '../../../utils/utils.dart';

part 'profile_repository.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProfileRepository(apiClient);
}

class ProfileRepository {
  final ApiClient apiClient;

  const ProfileRepository(this.apiClient);

  Future<UserModel> fetchDetailUser() async {
    try {
      final response = await apiClient.get<Map<String, dynamic>>(
        '/customer',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      final user = UserModel.fromJson(response);
      debugPrint('${Constants.tag} [AuthRepository.fetchDetailUser] Fetched user: ${user.toJson()}');
      return user;
    } on BadRequestException catch (e) {
      debugPrint('${Constants.tag} [AuthRepository.fetchDetailUser] BadRequestExceptions: ${e.message}}');
      throw e.message;
    } catch (e) {
      debugPrint('${Constants.tag} [AuthRepository.fetchDetailUser] ERROR: $e');
      throw Exception('Unexpected error occurred during fetching user details');
    }
  }

  Future<bool> updateAddress(String address) async {
    try {
      await apiClient.put(
        '/customer/update',
        data: {
          'address': address,
        },
      );
      return true;
    } on BadRequestException catch (e) {
      throw e.message;
    } catch (e) {
      debugPrint('${Constants.tag} [ProfileRepository.updateAddress] error: $e');
      return false;
    }
  }
}
