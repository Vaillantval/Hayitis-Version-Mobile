// lib/features/reviews/providers/review_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/review.dart';
import '../repositories/review_repository.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((_) => ReviewRepository());

final reviewsProvider = FutureProvider.family<List<Review>, int>((ref, productId) {
  return ref.read(reviewRepositoryProvider).getReviews(productId);
});
