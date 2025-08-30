import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/constants/assets.dart';
import 'package:flutter_mvvm_riverpod/constants/languages.dart';
import 'package:flutter_mvvm_riverpod/features/common/ui/widgets/secondary_button.dart';
import 'package:flutter_mvvm_riverpod/features/common/ui/widgets/star_rating.dart';
import 'package:flutter_mvvm_riverpod/features/job/model/worker_model.dart';
import 'package:flutter_mvvm_riverpod/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

final scannedUsersProvider = StateProvider<List<WorkerModel>>((ref) => []);

class FindWorkerScreen extends ConsumerStatefulWidget {
  const FindWorkerScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FindWorkerScreen> createState() => _FindWorkerScreenState();
}

class _FindWorkerScreenState extends ConsumerState<FindWorkerScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      _simulateUserScanning();
    });
  }

  void _simulateUserScanning() async {
    for (var worker in dummyWorkers) {
      await Future.delayed(const Duration(seconds: 2));
      final currentList = ref.read(scannedUsersProvider);
      ref.read(scannedUsersProvider.notifier).state = [...currentList, worker];
      _listKey.currentState?.insertItem(currentList.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scannedUsers = ref.watch(scannedUsersProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ✅ Radar animation
            Center(
              child: Lottie.asset(
                Assets.radar,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                animate: true,
                repeat: true,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              Languages.searchingNearbyWorker,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            // ✅ Animated list (show up to 5 users)
            Expanded(
              child: AnimatedList(
                key: _listKey,
                padding: const EdgeInsets.all(16),
                initialItemCount: scannedUsers.length > 5 ? 5 : scannedUsers.length,
                itemBuilder: (context, index, animation) {
                  if (index >= 5) return const SizedBox.shrink();
                  final user = scannedUsers[index];
                  return SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: 0.0,
                    child: Card(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: Text(user.name[0]),
                        ),
                        title: Text(user.name, style: AppTheme.title14),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StarRating(
                              rating: user.rating,
                              color: Colors.amber,
                              size: 14,
                            ),
                            Text(
                              "Rp. 20.000",
                              style: AppTheme.subtitle14,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ✅ View More button
            if (scannedUsers.length > 5)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: SecondaryButton(
                  text: '${Languages.viewAllWorkers} (${scannedUsers.length})',
                  onPressed: () {
                    // TODO: Navigate to full list screen
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
