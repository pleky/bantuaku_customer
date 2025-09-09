import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/extensions/string_extension.dart';
import 'package:flutter_mvvm_riverpod/theme/app_theme.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.statusColor,
    required this.status,
    required this.statusTextColor,
  });

  final Color statusColor;
  final String status;
  final Color statusTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.capitalFirstLetterAndLowercaseRest(),
        style: AppTheme.body12.copyWith(color: statusTextColor),
      ),
    );
  }
}
