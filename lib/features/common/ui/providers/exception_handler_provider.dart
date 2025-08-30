import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/utils/dio_error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final exceptionHandlerProvider = Provider<ExceptionHandler>((ref) {
  return ExceptionHandler(ref);
});

class ExceptionHandler {
  final Ref ref;

  ExceptionHandler(this.ref);

  void handle(Object error, BuildContext context) {
    if (error is DioException) {
      final message = DioErrorHandler.getErrorMessage(error);
      _showSnackBar(context, message);
    } else {
      _showSnackBar(context, 'Terjadi kesalahan tidak dikenal');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    if (message.isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
