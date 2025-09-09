import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/constants/languages.dart';
import 'package:flutter_mvvm_riverpod/features/common/ui/widgets/primary_button.dart';
import 'package:flutter_mvvm_riverpod/features/common/ui/widgets/shadow_box.dart';
import 'package:flutter_mvvm_riverpod/features/common/ui/widgets/star_rating.dart';
import 'package:flutter_mvvm_riverpod/features/common/ui/widgets/status_widget.dart';
import 'package:flutter_mvvm_riverpod/features/profile/ui/widgets/avatar.dart';
import 'package:flutter_mvvm_riverpod/routing/routes.dart';
import 'package:flutter_mvvm_riverpod/theme/app_colors.dart';
import 'package:flutter_mvvm_riverpod/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JobHistoryDetailScreen extends ConsumerStatefulWidget {
  const JobHistoryDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobHistoryDetailScreenState();
}

class _JobHistoryDetailScreenState extends ConsumerState<JobHistoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleTextStyle: AppTheme.title14.copyWith(color: Colors.black),
        title: const Text('Jumat, 24 Maret 2023'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatusWidget(
                  status: 'completed',
                  statusColor: AppColors.melon20,
                  statusTextColor: AppColors.melon60,
                ),
                Text(
                  "CRJS#1234567890",
                  style: AppTheme.body14.copyWith(color: AppColors.mono60),
                ),
              ],
            ),
            ShadowBox(
              radius: 8,
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  spacing: 4,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.mono20,
                      child: const Avatar(
                        url: 'https://randomuser.me/api/portraits/men/1.jpg',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ahmad Baskuri',
                          style: AppTheme.body14.copyWith(color: AppColors.mono60),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified,
                          size: 16,
                          color: AppColors.cempedak100,
                        ),
                      ],
                    ),
                    Text(
                      Languages.howWasTheService,
                      style: AppTheme.title16,
                    ),
                    Text(
                      Languages.rateService,
                      style: AppTheme.body12.copyWith(color: AppColors.mono80),
                      textAlign: TextAlign.center,
                    ),
                    StarRating(
                      rating: 0,
                      color: AppColors.mono40,
                      hideRatingValue: true,
                      size: 32,
                    ),
                  ],
                ),
              ),
            ),
            ShadowBox(
              radius: 8,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pembersihan Rumah',
                        style: AppTheme.title16,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_outlined,
                            size: 16,
                            color: AppColors.mono60,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '2 Jam',
                            style: AppTheme.body12.copyWith(color: AppColors.mono60),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    Languages.jobLocation,
                    style: AppTheme.title14,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Jl. Ijen Nirwana Raya Blok A No.16, Bareng,Kec. Klojen, Kota Malang, Jawa Timur 65116',
                    style: AppTheme.body12.copyWith(color: AppColors.mono80),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Languages.jobDescription,
                    style: AppTheme.title14,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Membersihkan seluruh bagian rumah termasuk menyapu, mengepel, dan membersihkan kamar mandi.',
                    style: AppTheme.body12.copyWith(color: AppColors.mono80),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Languages.paymentsDetails,
                    style: AppTheme.title14,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Languages.serviceFee,
                        style: AppTheme.body12.copyWith(color: AppColors.mono80),
                      ),
                      Text(
                        'Rp 100.000',
                        style: AppTheme.body12.copyWith(color: AppColors.mono80),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${Languages.tax} (10%)',
                        style: AppTheme.body12.copyWith(color: AppColors.mono80),
                      ),
                      Text(
                        'Rp 10.000',
                        style: AppTheme.body12.copyWith(color: AppColors.mono80),
                      ),
                    ],
                  ),
                  const Divider(height: 24, color: AppColors.mono20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Languages.totalPayment,
                        style: AppTheme.title14,
                      ),
                      Text(
                        'Rp 110.000',
                        style: AppTheme.title14,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.proofJob);
                    },
                    child: Text(
                      '${Languages.viewJobProof} (4)',
                      style: AppTheme.body12.copyWith(
                        color: AppColors.blueberry100,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle customer service action
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.headset_mic_outlined,
                    size: 16,
                    color: AppColors.mono60,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    Languages.customerService,
                    style: AppTheme.body12.copyWith(color: AppColors.mono60),
                  ),
                ],
              ),
            ),
            PrimaryButton(
              onPressed: () {
                context.pop();
              },
              text: Languages.back,
            ),
          ],
        ),
      ),
    );
  }
}
