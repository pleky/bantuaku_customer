import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/constants/assets.dart';
import 'package:flutter_mvvm_riverpod/constants/languages.dart';
import 'package:flutter_mvvm_riverpod/extensions/build_context_extension.dart';
import 'package:flutter_mvvm_riverpod/features/common/ui/widgets/common_status.dart';
import 'package:flutter_mvvm_riverpod/features/common/ui/widgets/material_ink_well.dart';
import 'package:flutter_mvvm_riverpod/routing/routes.dart';
import 'package:flutter_mvvm_riverpod/theme/app_colors.dart';
import 'package:flutter_mvvm_riverpod/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mono20,
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
              child: Content(),
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Card.outlined(
            color: context.primaryBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rp.98000"),
                  TextButton.icon(
                    icon: SvgPicture.asset(Assets.add),
                    onPressed: () {},
                    label: Text(
                      Languages.topup,
                      style: AppTheme.subtitle14.copyWith(
                        color: context.primaryTextColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          CommonStatus(
            textColor: context.successTextColor,
            status: Languages.completeProfile,
            backgroundColor: context.successBackgroundColor,
          ),
          const SizedBox(height: 32),
          MaterialInkWell(
            onTap: () => {context.push(Routes.createJob, extra: true)},
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.secondaryBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.dividerColor),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  Icon(
                    Icons.work,
                    size: 32,
                  ),
                  Text(Languages.jobQualifications),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          MaterialInkWell(
            onTap: () => {context.push(Routes.createJob, extra: false)},
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.secondaryBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.dividerColor),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  Icon(
                    Icons.work,
                    size: 32,
                  ),
                  Text(Languages.jobWithoutQualifications),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
