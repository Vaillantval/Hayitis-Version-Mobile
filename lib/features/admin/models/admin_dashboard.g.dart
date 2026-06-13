// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TopProductImpl _$$TopProductImplFromJson(Map<String, dynamic> json) =>
    _$TopProductImpl(
      name: json['name'] as String,
      sales: (json['sales'] as num).toInt(),
    );

Map<String, dynamic> _$$TopProductImplToJson(_$TopProductImpl instance) =>
    <String, dynamic>{'name': instance.name, 'sales': instance.sales};

_$RevenuePointImpl _$$RevenuePointImplFromJson(Map<String, dynamic> json) =>
    _$RevenuePointImpl(
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$$RevenuePointImplToJson(_$RevenuePointImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
    };

_$AdminDashboardImpl _$$AdminDashboardImplFromJson(Map<String, dynamic> json) =>
    _$AdminDashboardImpl(
      totalOrders: (json['total_orders'] as num).toInt(),
      pendingOrders: (json['pending_orders'] as num).toInt(),
      totalRevenue: (json['total_revenue'] as num).toDouble(),
      totalCustomers: (json['total_customers'] as num).toInt(),
      topProducts:
          (json['top_products'] as List<dynamic>)
              .map((e) => TopProduct.fromJson(e as Map<String, dynamic>))
              .toList(),
      revenueChart:
          (json['revenue_chart'] as List<dynamic>)
              .map((e) => RevenuePoint.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$AdminDashboardImplToJson(
  _$AdminDashboardImpl instance,
) => <String, dynamic>{
  'total_orders': instance.totalOrders,
  'pending_orders': instance.pendingOrders,
  'total_revenue': instance.totalRevenue,
  'total_customers': instance.totalCustomers,
  'top_products': instance.topProducts,
  'revenue_chart': instance.revenueChart,
};
