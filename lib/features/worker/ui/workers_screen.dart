import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/theme/app_colors.dart';
import 'package:flutter_mvvm_riverpod/theme/app_theme.dart';
import 'package:path/path.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Pekerja yang siap"),
            const SizedBox(height: 8),
            Column(
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
            const SizedBox(height: 16),
            _sectionHeader("Pekerja yang menawar"),
            const SizedBox(height: 8),
            Column(
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
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  // Cancel transaction
                },
                child: const Text("Batalkan Transaksi"),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
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
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Rp ${worker.price}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 8),
                if (type == WorkerCardType.ready)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    ),
                    onPressed: onSelect,
                    child: const Text("Pilih Pekerja"),
                  )
                else
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        ),
                        onPressed: onAccept,
                        child: const Text("Terima"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        ),
                        onPressed: onBid,
                        child: const Text("Tawar"),
                      ),
                    ],
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final int starCount;
  final Color color;
  final double size;

  const StarRating({
    Key? key,
    required this.rating,
    this.starCount = 5,
    this.color = Colors.orange,
    this.size = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stars = List.generate(starCount, (index) {
      final starValue = index + 1;
      if (rating >= starValue) {
        return Icon(Icons.star, color: color, size: size);
      } else if (rating > starValue - 1 && rating < starValue) {
        return Icon(Icons.star_half, color: color, size: size);
      } else {
        return Icon(Icons.star_border, color: color, size: size);
      }
    });

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...stars,
        const SizedBox(width: 4),
        Text(
          "(${rating.toStringAsFixed(1)})",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
