// lib/features/admin/repositories/admin_repository.dart
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../../../core/network/endpoints.dart';
import '../models/admin_dashboard.dart';
import '../models/inventory_item.dart';
import '../../products/models/product.dart';
import '../../orders/models/order.dart';
import '../../auth/models/user_profile.dart';
import '../../products/models/category.dart';

class AdminRepository {
  final Dio _dio = ApiClient.instance;

  static double _d(dynamic v) {
    if (v == null) return 0.0;
    if (v is num)  return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  /// Translates admin API field names → Flutter Product model field names.
  Map<String, dynamic> _remapProduct(Map<String, dynamic> raw) => {
    ...raw,
    'price':            _d(raw['solde_price']),
    'compare_at_price': _d(raw['regular_price']),
    'stock_quantity':   (raw['stock'] as num?)?.toInt() ?? 0,
    'in_stock':         raw['is_available'] ?? false,
    'currency':         'HTG',
    'rating_count':     0,
    'category':         null,
  };

  static List<int> _extractCategoryIds(Map<String, dynamic> raw) {
    final cats = raw['categories'] as List? ?? [];
    return cats.map((e) => (e as num).toInt()).toList();
  }

  Future<AdminDashboard> getDashboard() async {
    try {
      final results = await Future.wait([
        _dio.get(Endpoints.adminDashboard),
        _dio.get(Endpoints.adminCustomers, queryParameters: {'page_size': 1}),
      ]);
      final root = results[0].data as Map<String, dynamic>;
      final raw  = Map<String, dynamic>.from(root['data'] as Map<String, dynamic>);

      // Remap backend field names → Flutter model field names
      final rawTop   = raw['top_products']       as List? ?? [];
      final rawChart = raw['revenue_last_30_days'] as List? ?? [];

      final data = <String, dynamic>{
        'total_orders':   (raw['orders_today']       as num?)?.toInt()    ?? 0,
        'pending_orders': (raw['pending_orders']     as num?)?.toInt()    ?? 0,
        'total_revenue':  (raw['revenue_month']      as num?)?.toDouble() ?? 0.0,
        'total_customers': (results[1].data as Map<String, dynamic>)['count'] as int? ?? 0,
        'top_products': rawTop.map((e) {
          final m = e as Map<String, dynamic>;
          return {'name': m['product_name'] ?? '', 'sales': (m['total_sold'] as num?)?.toInt() ?? 0};
        }).toList(),
        'revenue_chart': rawChart.map((e) {
          final m = e as Map<String, dynamic>;
          return {'date': m['date'] as String, 'amount': (m['revenue'] as num?)?.toDouble() ?? 0.0};
        }).toList(),
      };
      return AdminDashboard.fromJson(data);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<List<Product>> getAdminProducts({
    String? search, String? category, bool? inStock, int page = 1,
    Map<int, List<int>>? outCategoryIds,
  }) async {
    try {
      final response = await _dio.get(Endpoints.adminProducts, queryParameters: {
        if (search != null)   'search':       search,
        if (category != null) 'category':     category,
        if (inStock != null)  'is_available': inStock,
        'page': page,
      });
      final data = response.data as Map<String, dynamic>;
      final raws = (data['results'] as List).cast<Map<String, dynamic>>();
      if (outCategoryIds != null) {
        for (final r in raws) {
          final id = (r['id'] as num).toInt();
          outCategoryIds[id] = _extractCategoryIds(r);
        }
      }
      return raws.map((e) => Product.fromJson(_remapProduct(e))).toList();
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<void> createProduct(Map<String, dynamic> data) async {
    try {
      await _dio.post(Endpoints.adminProducts, data: data);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<void> updateProduct(int id, Map<String, dynamic> data) async {
    try {
      await _dio.patch(Endpoints.adminProductDetail(id), data: data);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _dio.delete(Endpoints.adminProductDetail(id));
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<Product> getAdminProductDetail(int id) async {
    try {
      final response = await _dio.get(Endpoints.adminProductDetail(id));
      final root = response.data as Map<String, dynamic>;
      final data = root.containsKey('data') ? root['data'] as Map<String, dynamic> : root;
      return Product.fromJson(_remapProduct(data));
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<void> uploadProductImages(int id, List<String> filePaths) async {
    try {
      final formData = FormData.fromMap({
        'images': await Future.wait(filePaths.map((path) =>
            MultipartFile.fromFile(path, filename: path.split('/').last))),
      });
      await _dio.post(Endpoints.adminProductImages(id), data: formData);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<List<Order>> getAdminOrders({String? status, bool? isPaid, String? search, int page = 1}) async {
    try {
      final response = await _dio.get(Endpoints.adminOrders, queryParameters: {
        if (status != null)  'status':   status,
        if (isPaid != null)  'is_paid':  isPaid,
        if (search != null)  'search':   search,
        'page': page,
      });
      final data = response.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<Order> getAdminOrderDetail(int id) async {
    try {
      final response = await _dio.get(Endpoints.adminOrderDetail(id));
      final root = response.data as Map<String, dynamic>;
      return Order.fromJson(root['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<void> updateOrderStatus(int id, String status) async {
    try {
      await _dio.patch(Endpoints.adminOrderStatus(id), data: {'status': status});
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<List<UserProfile>> getCustomers({int page = 1}) async {
    try {
      final response = await _dio.get(Endpoints.adminCustomers, queryParameters: {'page': page});
      final data = response.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => UserProfile.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<Map<String, dynamic>> getCustomerDetail(int id) async {
    try {
      final response = await _dio.get(Endpoints.adminCustomerDetail(id));
      final root = response.data as Map<String, dynamic>;
      return root['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<List<InventoryItem>> getInventory({int threshold = 10}) async {
    try {
      final response = await _dio.get(Endpoints.adminInventory, queryParameters: {'threshold': threshold});
      final data = response.data as Map<String, dynamic>;
      return (data['results'] as List)
          .map((e) => InventoryItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<void> updateInventory(int id, int stockQuantity) async {
    try {
      await _dio.patch(Endpoints.adminInventoryDetail(id), data: {'stock_quantity': stockQuantity});
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<Map<String, dynamic>> getSalesReport({String period = 'monthly', String? start, String? end}) async {
    try {
      final results = await Future.wait([
        _dio.get(Endpoints.adminReportsSales, queryParameters: {
          'period': period,
          if (start != null) 'start': start,
          if (end != null)   'end':   end,
        }),
        _dio.get(Endpoints.adminOrders, queryParameters: {'page_size': 1}),
      ]);
      final root = results[0].data as Map<String, dynamic>;
      final data = Map<String, dynamic>.from((root['data'] as Map<String, dynamic>?) ?? {});
      // Inject total orders count (all statuses) from the orders endpoint
      data['total_orders_all'] = (results[1].data as Map<String, dynamic>)['count'] as int? ?? 0;
      return data;
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<Map<String, dynamic>> getProductsReport() async {
    try {
      final response = await _dio.get(Endpoints.adminReportsProducts);
      final root = response.data as Map<String, dynamic>;
      final data = root['data'];
      if (data is List) return {'results': data};
      return (data as Map<String, dynamic>?) ?? {};
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  // ─── Categories ───────────────────────────────────────────────
  Future<List<Category>> getAdminCategories() async {
    try {
      final response = await _dio.get(Endpoints.adminCategories);
      final data = response.data;
      List<dynamic> list;
      if (data is List) {
        list = data;
      } else if (data is Map && data.containsKey('data')) {
        list = data['data'] as List;
      } else if (data is Map && data.containsKey('results')) {
        list = data['results'] as List;
      } else {
        list = [];
      }
      return list.map((e) => Category.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<void> createAdminCategory(Map<String, dynamic> data, {String? imagePath}) async {
    try {
      final formData = FormData.fromMap({
        ...data,
        if (imagePath != null)
          'image': await MultipartFile.fromFile(imagePath, filename: imagePath.split('/').last),
      });
      await _dio.post(Endpoints.adminCategories, data: formData);
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<void> updateAdminCategory(int id, Map<String, dynamic> data, {String? imagePath}) async {
    try {
      if (imagePath != null) {
        final formData = FormData.fromMap({
          ...data,
          'image': await MultipartFile.fromFile(imagePath, filename: imagePath.split('/').last),
        });
        await _dio.patch(Endpoints.adminCategoryDetail(id), data: formData);
      } else {
        await _dio.patch(Endpoints.adminCategoryDetail(id), data: data);
      }
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<void> deleteAdminCategory(int id) async {
    try {
      await _dio.delete(Endpoints.adminCategoryDetail(id));
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }

  Future<Map<String, dynamic>> getCustomersReport() async {
    try {
      final response = await _dio.get(Endpoints.adminReportsCustomers);
      final root = response.data as Map<String, dynamic>;
      final data = root['data'];
      if (data is List) return {'results': data};
      return (data as Map<String, dynamic>?) ?? {};
    } on DioException catch (e) {
      throw ApiException.fromJson(e.response?.data as Map<String, dynamic>? ?? {});
    }
  }
}
