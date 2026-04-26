import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final Function(double) onRatingChanged;
  final double size;

  const StarRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.size = 40, // Aumentado de 30 a 40
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        return GestureDetector(
          onTap: () => onRatingChanged(starIndex.toDouble()),
          onLongPress: () => onRatingChanged(starIndex - 0.5),
          child: Container(
            padding: const EdgeInsets.all(4),
            child: Icon(
              _getStarIcon(starIndex),
              color: Colors.amber,
              size: size,
            ),
          ),
        );
      }),
    );
  }

  IconData _getStarIcon(int starIndex) {
    if (rating >= starIndex) {
      return Icons.star;
    } else if (rating >= starIndex - 0.5) {
      return Icons.star_half;
    } else {
      return Icons.star_border;
    }
  }
}