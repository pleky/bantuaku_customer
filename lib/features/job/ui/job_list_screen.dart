
import 'package:flutter/material.dart';
import 'package:bantuaku_customer/constants/languages.dart';
import 'package:bantuaku_customer/features/job/model/job_model.dart';
import 'package:bantuaku_customer/features/job/ui/widget/job_card_widget.dart';
import 'package:bantuaku_customer/routing/routes.dart';
import 'package:bantuaku_customer/theme/app_colors.dart';
import 'package:bantuaku_customer/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class JobListScreen extends ConsumerStatefulWidget {
  const JobListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobListScreenState();
}

class _JobListScreenState extends ConsumerState<JobListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Languages.activityHistory),
      ),
      backgroundColor: AppColors.whiteBg,
      body: SafeArea(
        child: const Content(),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            itemCount: joblistData.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return JobCard(
                title: joblistData[index].title,
                price: Utils.formatRupiah(int.parse(joblistData[index].price)),
                date: joblistData[index].date,
                status: joblistData[index].status,
                statusColor: joblistData[index].status == "DONE" ? AppColors.melon10 : AppColors.rambutan10,
                statusTextColor: joblistData[index].status == "DONE" ? AppColors.melon60 : AppColors.rambutan100,
                onTap: () {
                  context.pushNamed(Routes.jobHistoryDetail);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
