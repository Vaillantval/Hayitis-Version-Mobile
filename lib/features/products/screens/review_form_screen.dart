// lib/features/products/screens/review_form_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/star_rating.dart';
import '../../reviews/repositories/review_repository.dart';
import '../../reviews/providers/review_provider.dart';
import '../providers/product_provider.dart';

class ReviewFormScreen extends ConsumerStatefulWidget {
  final String productSlug;
  const ReviewFormScreen({super.key, required this.productSlug});

  @override
  ConsumerState<ReviewFormScreen> createState() => _ReviewFormScreenState();
}

class _ReviewFormScreenState extends ConsumerState<ReviewFormScreen> {
  final _commentCtrl = TextEditingController();
  int _rating = 0;
  bool _isLoading = false;

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_rating == 0) {
      Fluttertoast.showToast(msg: 'Veuillez donner une note');
      return;
    }
    if (_commentCtrl.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Veuillez écrire un commentaire');
      return;
    }
    setState(() => _isLoading = true);
    try {
      final product = ref.read(productDetailProvider(widget.productSlug)).valueOrNull;
      if (product == null) return;
      await ReviewRepository().createReview(
        productId: product.id,
        rating:    _rating,
        comment:   _commentCtrl.text.trim(),
      );
      ref.invalidate(reviewsProvider(product.id));
      Fluttertoast.showToast(msg: 'Avis soumis avec succès !');
      if (mounted) context.pop();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString().replaceAll('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laisser un avis')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Votre note', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            InteractiveStarRating(onRatingChanged: (r) => setState(() => _rating = r)),
            const SizedBox(height: 24),
            const Text('Votre commentaire', style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _commentCtrl,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Partagez votre expérience...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(label: 'Envoyer mon avis', onPressed: _submit, isLoading: _isLoading),
          ],
        ),
      ),
    );
  }
}
