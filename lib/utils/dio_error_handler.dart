import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';

class DioErrorHandler {
  static String getErrorMessage(DioException error) {
    final data = error.response?.data;

    // Jika data adalah Map (json object)
    if (data is Map<String, dynamic>) {
      final message = data['message'] ?? 'Terjadi kesalahan';

      final errors = data['errors'];
      if (errors is Map<String, dynamic>) {
        for (final field in errors.entries) {
          if (field.value is List && field.value.isNotEmpty) {
            return field.value.first;
          }
        }
      }

      return message;
    }

    // Fallback ke pesan error Dio
    return error.message ?? 'Terjadi kesalahan jaringan';
  }

  static List<String> getAllMessages(DioException error) {
    final List<String> messages = [];
    final data = error.response?.data;
    debugPrint('DioErrorHandler.getAllMessages: $data');

    if (data is Map<String, dynamic>) {
      final errors = data['errors'];
      if (errors is Map<String, dynamic>) {
        for (final field in errors.entries) {
          if (field.value is List) {
            messages.addAll(field.value);
          }
        }
      }
    }

    return messages;
  }
}

String parseErrorResponse(Map<String, dynamic> data) {
  final StringBuffer buffer = StringBuffer();

  // Tambahkan pesan utama jika ada
  final message = data['message'];
  if (message != null && message is String) {
    buffer.writeln(message);
  }

  // Tangani bagian errors
  final errors = data['errors'];
  if (errors != null && errors is Map<String, dynamic>) {
    errors.forEach((key, value) {
      if (value is List) {
        for (final msg in value) {
          buffer.writeln(msg.toString());
        }
      } else {
        buffer.writeln(value.toString());
      }
    });
  }

  return buffer.toString().trim();
}
