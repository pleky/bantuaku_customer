import 'package:flutter/material.dart';

import '../../../../extensions/date_time_extension.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme.dart';

class PremiumInfoButton extends StatelessWidget {
  final DateTime? expiryDate;

  const PremiumInfoButton({super.key, required this.expiryDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.cempedak60,
            AppColors.cempedak100,
          ],
        ),
      ),
      child: expiryDate == null
          ? Text(
              "Expairy date not found",
              style: AppTheme.title14.copyWith(
                color: AppColors.mono0,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Premium until",
                  style: AppTheme.title14.copyWith(
                    color: AppColors.mono0,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  "until",
                  style: AppTheme.body14.copyWith(
                    color: AppColors.mono0,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  (expiryDate ?? DateTime.now()).toddMMYYYY(),
                  style: AppTheme.title14.copyWith(
                    color: AppColors.mono0,
                  ),
                ),
              ],
            ),
    );
  }
}
