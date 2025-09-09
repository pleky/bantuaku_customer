import 'package:flutter/material.dart';
import 'package:bantuaku_customer/features/common/ui/widgets/primary_button.dart';
import 'package:bantuaku_customer/features/common/ui/widgets/star_rating.dart';
import 'package:bantuaku_customer/theme/app_colors.dart';
import 'package:bantuaku_customer/theme/app_theme.dart';
import 'package:bantuaku_customer/utils/utils.dart';

class WorkersScreen extends StatelessWidget {
  const WorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final readyWorkers = [
      Worker(name: "Zaenal", rating: 4.5, price: 20000, image: "https://i.pravatar.cc/100"),
      Worker(name: "NagaBonar", rating: 4.8, price: 20000, image: "https://i.pravatar.cc/101"),
      Worker(name: "Jendral Kancil", rating: 4.2, price: 20000, image: "https://i.pravatar.cc/102"),
    ];

    final biddingWorkers = [
      Worker(name: "Agus", rating: 4.5, price: 23000, image: "https://i.pravatar.cc/103"),
      Worker(name: "Abdul", rating: 4.5, price: 27000, image: "https://i.pravatar.cc/104"),
      Worker(name: "Salim", rating: 4.5, price: 35000, image: "https://i.pravatar.cc/105"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ada Beberapa Pekerja yang menawar nih",
          style: AppTheme.title14,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Pekerja yang siap"),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: readyWorkers.map((worker) {
                  return WorkerCard(
                    worker: worker,
                    type: WorkerCardType.ready,
                    onSelect: () {
                      // TODO: Navigate or handle select
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            _sectionHeader("Pekerja yang menawar"),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: biddingWorkers.map((worker) {
                  return WorkerCard(
                    worker: worker,
                    type: WorkerCardType.bidding,
                    onAccept: () {
                      // TODO: Accept logic
                    },
                    onBid: () {
                      // TODO: Bid logic
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PrimaryButton(
                backgroundColor: AppColors.schema103,
                onPressed: () {
                  // Cancel transaction
                },
                text: "Batalkan Transaksi",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Container(
      width: double.infinity,
      color: AppColors.schema104,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: AppTheme.subtitle14.copyWith(
          color: AppColors.whiteBg,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Worker {
  final String name;
  final double rating;
  final int price;
  final String image;

  Worker({required this.name, required this.rating, required this.price, required this.image});
}

enum WorkerCardType { ready, bidding }

class WorkerCard extends StatelessWidget {
  final Worker worker;
  final WorkerCardType type;
  final VoidCallback? onSelect;
  final VoidCallback? onAccept;
  final VoidCallback? onBid;

  const WorkerCard({
    super.key,
    required this.worker,
    required this.type,
    this.onSelect,
    this.onAccept,
    this.onBid,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(worker.image),
                  radius: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(worker.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          StarRating(rating: worker.rating, size: 16),
                          Spacer(),
                          Text(Utils.formatRupiah(worker.price), style: AppTheme.subtitle12),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (type == WorkerCardType.ready)
              PrimaryButton(
                text: "Pilih Pekerja",
                onPressed: () {},
              )
            else
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryDark),
                      onPressed: () {},
                      child: const Text("Terima", style: TextStyle(color: AppColors.whiteBg)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.cempedak70),
                      onPressed: () {},
                      child: const Text("Tawar"),
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
