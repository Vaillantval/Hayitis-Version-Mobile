// lib/features/products/providers/product_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/cache/cache_service.dart';
import '../models/product.dart';
import '../models/product_detail.dart';
import '../models/category.dart';
import '../models/slider.dart';
import '../repositories/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>((_) => ProductRepository());

Future<List<Product>> _loadWithCache(
  String cacheKey,
  Future<List<Product>> Function() fetch,
) async {
  try {
    final products = await fetch();
    await CacheService.save(cacheKey, jsonEncode(products.map((p) => p.toJson()).toList()));
    return products;
  } catch (_) {
    final cached = await CacheService.load(cacheKey);
    if (cached != null) {
      return (jsonDecode(cached) as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    rethrow;
  }
}

final featuredProductsProvider = FutureProvider<List<Product>>((ref) =>
    _loadWithCache('cache_featured', () => ref.read(productRepositoryProvider).getFeatured()));

final newArrivalsProvider = FutureProvider<List<Product>>((ref) =>
    _loadWithCache('cache_new_arrivals', () => ref.read(productRepositoryProvider).getNewArrivals()));

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  const cacheKey = 'cache_categories';
  try {
    final cats = await ref.read(productRepositoryProvider).getCategories();
    await CacheService.save(cacheKey, jsonEncode(cats.map((c) => c.toJson()).toList()));
    return cats;
  } catch (_) {
    final cached = await CacheService.load(cacheKey);
    if (cached != null) {
      return (jsonDecode(cached) as List)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    rethrow;
  }
});

final productDetailProvider = FutureProvider.family<ProductDetail, String>((ref, slug) async {
  final cacheKey = 'cache_product_$slug';
  try {
    final product = await ref.read(productRepositoryProvider).getProductDetail(slug);
    await CacheService.save(cacheKey, jsonEncode(product.toJson()));
    return product;
  } catch (_) {
    final cached = await CacheService.load(cacheKey);
    if (cached != null) {
      return ProductDetail.fromJson(jsonDecode(cached) as Map<String, dynamic>);
    }
    rethrow;
  }
});

final searchResultsProvider = FutureProvider.family<List<Product>, String>((ref, query) {
  if (query.isEmpty) return Future.value([]);
  return ref.read(productRepositoryProvider).searchProducts(query);
});

final slidersProvider = FutureProvider<List<HeroSlide>>((ref) async {
  const cacheKey = 'cache_sliders';
  try {
    final slides = await ref.read(productRepositoryProvider).getSliders();
    await CacheService.save(cacheKey, jsonEncode(slides.map((s) => s.toJson()).toList()));
    return slides;
  } catch (_) {
    final cached = await CacheService.load(cacheKey);
    if (cached != null) {
      return (jsonDecode(cached) as List)
          .map((e) => HeroSlide.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
});
