// lib/shared/widgets/star_rating.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final int count;
  final double size;

  const StarRating({super.key, required this.rating, this.count = 5, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        if (i < rating.floor()) {
          return Icon(Icons.star, color: AppColors.warning, size: size);
        } else if (i < rating) {
          return Icon(Icons.star_half, color: AppColors.warning, size: size);
        }
        return Icon(Icons.star_outline, color: AppColors.warning, size: size);
      }),
    );
  }
}

class InteractiveStarRating extends StatefulWidget {
  final int initialRating;
  final void Function(int) onRatingChanged;
  final double size;

  const InteractiveStarRating({
    super.key,
    this.initialRating = 0,
    required this.onRatingChanged,
    this.size = 32,
  });

  @override
  State<InteractiveStarRating> createState() => _InteractiveStarRatingState();
}

class _InteractiveStarRatingState extends State<InteractiveStarRating> {
  late int _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        return GestureDetector(
          onTap: () {
            setState(() => _rating = i + 1);
            widget.onRatingChanged(i + 1);
          },
          child: Icon(
            i < _rating ? Icons.star : Icons.star_outline,
            color: AppColors.warning,
            size: widget.size,
          ),
        );
      }),
    );
  }
}
