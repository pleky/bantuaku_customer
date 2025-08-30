import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

String? notEmptyEmailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'validator_required_field'.tr();
  }

  if (!isValidEmail(value.trim())) {
    return 'validator_invalid_email_format'.tr();
  }

  // Return null if the value is valid
  return null;
}

bool isValidEmail(String email) {
  // Define a regex pattern to match email format
  final regExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zA-Z]+)+$");
  return regExp.hasMatch(email);
}

String? passwordMatchValidator({
  required String? confirmPassword,
  required String? originalPassword,
}) {
  debugPrint("Validating password match: $confirmPassword against $originalPassword");
  if (confirmPassword == null || confirmPassword.isEmpty) {
    debugPrint("Confirm password is empty");
    return 'Confirm password is required';
  }

  if (originalPassword != confirmPassword) {
    debugPrint("Passwords do not match: $confirmPassword != $originalPassword");
    return 'Passwords do not match';
  }

  return null;
}
