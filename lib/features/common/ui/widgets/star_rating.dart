import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/theme/app_theme.dart';

class StarRating extends StatelessWidget {
  final double rating; // e.g., 4.5
  final int starCount; // default 5
  final Color color; // star color
  final double size; // star size
  final TextStyle? textStyle;

  const StarRating({
    Key? key,
    required this.rating,
    this.starCount = 5,
    this.color = Colors.orange,
    this.size = 24,
    this.textStyle,
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
        const SizedBox(width: 2),
        Text(
          "(${rating.toStringAsFixed(1)})",
          style: AppTheme.subtitle12,
        ),
      ],
    );
  }
}
