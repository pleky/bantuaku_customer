import 'package:flutter/material.dart';
import 'package:bantuaku_customer/theme/app_colors.dart';
import 'package:bantuaku_customer/theme/app_theme.dart';

class StarRating extends StatefulWidget {
  final double rating; // initial rating
  final int starCount;
  final Color color; // default star color
  final double size;
  final TextStyle? textStyle;
  final bool hideRatingValue;
  final ValueChanged<double>? onRatingChanged;

  const StarRating({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.color = Colors.grey, // default warna sebelum dipilih
    this.size = 24,
    this.textStyle,
    this.hideRatingValue = false,
    this.onRatingChanged,
  });

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late double currentRating;

  @override
  void initState() {
    super.initState();
    currentRating = widget.rating;
  }

  void _handleRatingTap(int index) {
    final newRating = index + 1.0;
    setState(() {
      currentRating = newRating;
    });
    widget.onRatingChanged?.call(newRating);
  }

  @override
  Widget build(BuildContext context) {
    final stars = List.generate(widget.starCount, (index) {
      final starValue = index + 1;
      IconData icon;
      if (currentRating >= starValue) {
        icon = Icons.star;
      } else if (currentRating > starValue - 1 && currentRating < starValue) {
        icon = Icons.star_half;
      } else {
        icon = Icons.star_border;
      }

      // Jika rating >= starValue → warna kuning, else default warna
      final starColor = (starValue <= currentRating) ? AppColors.cempedak100 : widget.color;

      return GestureDetector(
        onTap: () => _handleRatingTap(index),
        child: Icon(icon, color: starColor, size: widget.size),
      );
    });

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...stars,
        const SizedBox(width: 4),
        if (!widget.hideRatingValue)
          Text(
            "(${currentRating.toStringAsFixed(1)})",
            style: widget.textStyle ?? AppTheme.subtitle12,
          ),
      ],
    );
  }
}
