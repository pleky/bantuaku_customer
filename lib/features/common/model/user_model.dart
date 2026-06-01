import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';
part 'user_model.freezed.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    @JsonKey(name: 'full_name') required String fullName,
    required String username,
    required String email,
    required String phone,
    required String address,
    @JsonKey(name: 'is_aktif') required bool isAktif,
    required String balance,
    @JsonKey(name: 'google_id') String? googleId,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.empty() => UserModel(
        id: 0,
        fullName: '',
        username: '',
        email: '',
        phone: '',
        address: '',
        isAktif: false,
        balance: '0.00',
        googleId: null,
      );

  factory UserModel.fromString(String userString) {
    print('Decoding user string: $userString');
    // final json = jsonDecode(userString);
    // print('Decoded JSON: $json');
    // final Map<String, dynamic> userMap = Map<String, dynamic>.from(jsonDecode(userString));
    return UserModel.empty();
  }
}

// {
//     "id": 31,
//     "full_name": "Yogatama Cust2",
//     "username": "yogatamacust",
//     "email": "egiantoroy2@gmail.com",
//     "phone": "0812786552671",
//     "address": "Sawangan Depok 2",
//     "is_aktif": false,
//     "balance": "77000.00",
//     "google_id": null,
    
// }