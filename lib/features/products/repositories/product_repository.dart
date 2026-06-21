// lib/features/products/repositories/product_repository.dart
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/endpoints.dart';
import '../models/product.dart';
import '../models/product_detail.dart';
import '../models/category.dart';
import '../models/slider.dart';

class PaginatedProducts {
  final int count;
  final String? next;
  final List<Product> results;
  PaginatedProducts({required this.count, this.next, required this.results});
}

class ProductRepository {
  final Dio _dio = ApiClient.instance;

  Future<PaginatedProducts> getProducts({
    String? category,
    double? minPrice,
    double? maxPrice,
    bool? inStock,
    String? search,
    String? ordering,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(Endpoints.products, queryParameters: {
        if (category != null)  'category':  category,
        if (minPrice != null)  'min_price':  minPrice,
        if (maxPrice != null)  'max_price':  maxPrice,
        if (inStock != null)   'in_stock':   inStock,
        if (search != null)    'search':     search,
        if (ordering != null)  'ordering':   ordering,
        'page': page,
      });
      final data = response.data as Map<String, dynamic>;
      return PaginatedProducts(
        count:   data['count'] as int,
        next:    data['next'] as String?,
        results: (data['results'] as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await _dio.get(Endpoints.productsSearch, queryParameters: {'q': query});
      final data = response.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<List<Product>> getFeatured() async {
    try {
      final response = await _dio.get(Endpoints.featured);
      final data = response.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<List<Product>> getNewArrivals() async {
    try {
      final response = await _dio.get(Endpoints.newArrivals);
      final data = response.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<ProductDetail> getProductDetail(String slug) async {
    try {
      final response = await _dio.get(Endpoints.productDetail(slug));
      return ProductDetail.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<List<Product>> getRelated(String slug) async {
    try {
      final response = await _dio.get(Endpoints.productRelated(slug));
      final data = response.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (_) {
      return [];
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio.get(Endpoints.categories);
      final data = response.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<List<HeroSlide>> getSliders() async {
    try {
      final response = await _dio.get(Endpoints.sliders);
      final data = response.data as Map<String, dynamic>;
      final list = data['results'] as List? ?? data['data'] as List? ?? response.data as List;
      return list.map((e) => HeroSlide.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
