import 'package:bantuaku_customer/constants/constants.dart';
import 'package:bantuaku_customer/features/common/ui/widgets/common_shimmer.dart';
import 'package:bantuaku_customer/features/home/ui/state/home_state.dart';
import 'package:bantuaku_customer/features/home/ui/view_model/home_view_model.dart';
import 'package:bantuaku_customer/features/profile/ui/view_model/profile_view_model.dart';
import 'package:bantuaku_customer/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:bantuaku_customer/constants/languages.dart';
import 'package:bantuaku_customer/extensions/build_context_extension.dart';
import 'package:bantuaku_customer/features/common/ui/widgets/common_status.dart';
import 'package:bantuaku_customer/features/common/ui/widgets/shadow_box.dart';
import 'package:bantuaku_customer/routing/routes.dart';
import 'package:bantuaku_customer/theme/app_colors.dart';
import 'package:bantuaku_customer/theme/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                color: AppColors.schema104,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.2,
              right: 0,
              left: 0,
              child: Content(
                name: state.value?.profile?.fullName ?? "",
                balance: state.value?.profile?.balance ?? "0.0",
                isLoading: state.isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    super.key,
    required this.name,
    required this.isLoading,
    required this.balance,
  });

  final String name;
  final bool isLoading;
  final String balance;

  void _copyFCMToken() async {
    final sharedPreference = await SharedPreferences.getInstance();
    final fcmToken = sharedPreference.getString(Constants.fcmTokenKey) ?? '';
    await Clipboard.setData(ClipboardData(text: fcmToken));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Content build with name: $name, isLoading: $isLoading");
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadowBox(
            radius: 8,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLoading
                    ? CommonShimmer(child: Container(width: 100, height: 20, color: AppColors.mono0))
                    : Text(
                        name,
                        style: AppTheme.title16.copyWith(color: context.primaryTextColor),
                      ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Saldo Anda",
                          style: AppTheme.subtitle12.copyWith(color: context.secondaryTextColor),
                        ),
                        isLoading
                            ? CommonShimmer(child: Container(width: 150, height: 24, color: AppColors.mono0))
                            : Text(
                                Utils.formatRupiah(double.tryParse(balance) ?? 0.0),
                                style: AppTheme.title14.copyWith(color: context.primaryTextColor),
                              ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.primaryBackgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            HugeIcons.strokeRoundedWalletAdd02,
                            color: context.primaryTextColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _copyFCMToken,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.primaryBackgroundColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              HugeIcons.strokeRoundedTransactionHistory,
                              color: context.primaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          CommonStatus(
            textColor: context.successTextColor,
            status: Languages.completeProfile,
            backgroundColor: context.successBackgroundColor,
          ),
          const SizedBox(height: 16),
          Text(
            Languages.createJob,
            style: AppTheme.title16.copyWith(color: context.primaryTextColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => {context.push(Routes.createJob, extra: true)},
            child: ShadowBox(
              radius: 8,
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.secondaryBackgroundColor,
                    ),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Languages.jobQualifications,
                          style: AppTheme.title16.copyWith(color: context.primaryTextColor),
                        ),
                        Text(
                          "Buat pekerjaan dengan menentukan kualifikasi tertentu untuk pekerjaan Anda.",
                          style: AppTheme.subtitle12.copyWith(color: context.secondaryTextColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => {context.push(Routes.createJob, extra: false)},
            child: ShadowBox(
              radius: 8,
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.secondaryBackgroundColor,
                    ),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Languages.jobWithoutQualifications,
                          style: AppTheme.title16.copyWith(color: context.primaryTextColor),
                        ),
                        Text(
                          "Buat pekerjaan tanpa harus menentukan kualifikasi tertentu untuk pekerjaan Anda.",
                          style: AppTheme.subtitle12.copyWith(color: context.secondaryTextColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Riwayat Saldo",
            style: AppTheme.title16.copyWith(color: context.primaryTextColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          ShadowBox(
            radius: 8,
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Up Saldo",
                      style: AppTheme.body12.copyWith(color: context.primaryTextColor),
                    ),
                    Text(
                      "+ Rp50.000",
                      style: AppTheme.body12.copyWith(color: AppColors.melon60),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pembayaran Pembersihan Rumah",
                      style: AppTheme.body12.copyWith(color: context.primaryTextColor),
                    ),
                    Text(
                      "- Rp20.000",
                      style: AppTheme.body12.copyWith(color: AppColors.rambutan100),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Up Saldo",
                      style: AppTheme.body12.copyWith(color: context.primaryTextColor),
                    ),
                    Text(
                      "+ Rp100.000",
                      style: AppTheme.body12.copyWith(color: AppColors.melon60),
                    ),
                  ],
                ),
                Divider(height: 20, color: AppColors.mono20),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text("Lihat Semua", style: AppTheme.subtitle12.copyWith(color: context.primaryTextColor)),
                  Icon(Icons.arrow_forward_ios, size: 16, color: context.primaryTextColor),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
