// lib/features/admin/models/admin_dashboard.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_dashboard.freezed.dart';
part 'admin_dashboard.g.dart';

@freezed
class TopProduct with _$TopProduct {
  const factory TopProduct({
    required String name,
    required int sales,
  }) = _TopProduct;

  factory TopProduct.fromJson(Map<String, dynamic> json) =>
      _$TopProductFromJson(json);
}

@freezed
class RevenuePoint with _$RevenuePoint {
  const factory RevenuePoint({
    required DateTime date,
    required double amount,
  }) = _RevenuePoint;

  factory RevenuePoint.fromJson(Map<String, dynamic> json) =>
      _$RevenuePointFromJson(json);
}

@freezed
class AdminDashboard with _$AdminDashboard {
  const factory AdminDashboard({
    @JsonKey(name: 'total_orders')   required int totalOrders,
    @JsonKey(name: 'pending_orders') required int pendingOrders,
    @JsonKey(name: 'total_revenue')  required double totalRevenue,
    @JsonKey(name: 'total_customers')required int totalCustomers,
    @JsonKey(name: 'top_products')   required List<TopProduct> topProducts,
    @JsonKey(name: 'revenue_chart')  required List<RevenuePoint> revenueChart,
  }) = _AdminDashboard;

  factory AdminDashboard.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardFromJson(json);
}
