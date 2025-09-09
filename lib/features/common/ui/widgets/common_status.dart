import 'package:flutter/material.dart';
import 'package:bantuaku_customer/theme/app_theme.dart';

class CommonStatus extends StatelessWidget {
  const CommonStatus({
    super.key,
    required this.status,
    required this.backgroundColor,
    required this.textColor,
  });

  final String status;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: Text(
        status,
        style: AppTheme.subtitle12.copyWith(
          color: textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
