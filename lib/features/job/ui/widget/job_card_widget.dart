import 'package:flutter/material.dart';
import 'package:bantuaku_customer/extensions/build_context_extension.dart';
import 'package:bantuaku_customer/features/common/ui/widgets/material_ink_well.dart';
import 'package:bantuaku_customer/features/common/ui/widgets/shadow_box.dart';
import 'package:bantuaku_customer/features/common/ui/widgets/status_widget.dart';
import 'package:bantuaku_customer/theme/app_colors.dart';
import 'package:bantuaku_customer/theme/app_theme.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.title,
    required this.price,
    required this.date,
    required this.status,
    required this.onTap,
    this.statusColor = AppColors.melon10,
    this.statusTextColor = AppColors.melon40,
  });

  final String title;
  final String price;
  final String date;
  final String status;
  final VoidCallback onTap;
  final Color statusColor;
  final Color statusTextColor;

  @override
  Widget build(BuildContext context) {
    return MaterialInkWell(
      onTap: onTap,
      child: ShadowBox(
        radius: 8,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTheme.title14,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                StatusWidget(
                  status: status,
                  statusColor: statusColor,
                  statusTextColor: statusTextColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(MingCuteIcons.mgc_calendar_line, size: 16, color: AppColors.mono60),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: AppTheme.body12.copyWith(color: AppColors.mono60),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(HugeIcons.strokeRoundedPinLocation01, size: 16, color: context.primaryTextColor),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "Jl. Kenangan No. 123, Jakarta Selatan",
                    style: AppTheme.body12.copyWith(color: AppColors.mono80),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(MingCuteIcons.mgc_time_line, size: 16, color: context.primaryTextColor),
                const SizedBox(width: 4),
                Text(
                  "2 Jam",
                  style: AppTheme.body12.copyWith(color: AppColors.mono80),
                ),
              ],
            ),
            Divider(height: 20, color: AppColors.mono20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Pembayaran",
                  style: AppTheme.subtitle12.copyWith(color: AppColors.mono80),
                ),
                Text(
                  price,
                  style: AppTheme.title12.copyWith(color: context.primaryTextColor),
                ),
              ],
            ),
            Divider(height: 20, color: AppColors.mono20),
            Text(
              "Bantuan yang diberikan",
              style: AppTheme.subtitle12.copyWith(color: AppColors.mono80),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ShadowBox(
                  radius: 4,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    "Membersihkan Rumah",
                    style: AppTheme.body12.copyWith(color: AppColors.mono80),
                  ),
                ),
                ShadowBox(
                  radius: 4,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    "Mencuci Piring",
                    style: AppTheme.body12.copyWith(color: AppColors.mono80),
                  ),
                ),
                ShadowBox(
                  radius: 4,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    "Menyapu Lantai",
                    style: AppTheme.body12.copyWith(color: AppColors.mono80),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
