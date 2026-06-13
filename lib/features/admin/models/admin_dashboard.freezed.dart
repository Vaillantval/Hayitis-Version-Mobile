// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TopProduct _$TopProductFromJson(Map<String, dynamic> json) {
  return _TopProduct.fromJson(json);
}

/// @nodoc
mixin _$TopProduct {
  String get name => throw _privateConstructorUsedError;
  int get sales => throw _privateConstructorUsedError;

  /// Serializes this TopProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopProductCopyWith<TopProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopProductCopyWith<$Res> {
  factory $TopProductCopyWith(
    TopProduct value,
    $Res Function(TopProduct) then,
  ) = _$TopProductCopyWithImpl<$Res, TopProduct>;
  @useResult
  $Res call({String name, int sales});
}

/// @nodoc
class _$TopProductCopyWithImpl<$Res, $Val extends TopProduct>
    implements $TopProductCopyWith<$Res> {
  _$TopProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? sales = null}) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            sales:
                null == sales
                    ? _value.sales
                    : sales // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TopProductImplCopyWith<$Res>
    implements $TopProductCopyWith<$Res> {
  factory _$$TopProductImplCopyWith(
    _$TopProductImpl value,
    $Res Function(_$TopProductImpl) then,
  ) = __$$TopProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int sales});
}

/// @nodoc
class __$$TopProductImplCopyWithImpl<$Res>
    extends _$TopProductCopyWithImpl<$Res, _$TopProductImpl>
    implements _$$TopProductImplCopyWith<$Res> {
  __$$TopProductImplCopyWithImpl(
    _$TopProductImpl _value,
    $Res Function(_$TopProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TopProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? sales = null}) {
    return _then(
      _$TopProductImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        sales:
            null == sales
                ? _value.sales
                : sales // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TopProductImpl implements _TopProduct {
  const _$TopProductImpl({required this.name, required this.sales});

  factory _$TopProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopProductImplFromJson(json);

  @override
  final String name;
  @override
  final int sales;

  @override
  String toString() {
    return 'TopProduct(name: $name, sales: $sales)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopProductImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sales, sales) || other.sales == sales));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, sales);

  /// Create a copy of TopProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopProductImplCopyWith<_$TopProductImpl> get copyWith =>
      __$$TopProductImplCopyWithImpl<_$TopProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopProductImplToJson(this);
  }
}

abstract class _TopProduct implements TopProduct {
  const factory _TopProduct({
    required final String name,
    required final int sales,
  }) = _$TopProductImpl;

  factory _TopProduct.fromJson(Map<String, dynamic> json) =
      _$TopProductImpl.fromJson;

  @override
  String get name;
  @override
  int get sales;

  /// Create a copy of TopProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopProductImplCopyWith<_$TopProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RevenuePoint _$RevenuePointFromJson(Map<String, dynamic> json) {
  return _RevenuePoint.fromJson(json);
}

/// @nodoc
mixin _$RevenuePoint {
  DateTime get date => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;

  /// Serializes this RevenuePoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RevenuePoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RevenuePointCopyWith<RevenuePoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevenuePointCopyWith<$Res> {
  factory $RevenuePointCopyWith(
    RevenuePoint value,
    $Res Function(RevenuePoint) then,
  ) = _$RevenuePointCopyWithImpl<$Res, RevenuePoint>;
  @useResult
  $Res call({DateTime date, double amount});
}

/// @nodoc
class _$RevenuePointCopyWithImpl<$Res, $Val extends RevenuePoint>
    implements $RevenuePointCopyWith<$Res> {
  _$RevenuePointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RevenuePoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? amount = null}) {
    return _then(
      _value.copyWith(
            date:
                null == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            amount:
                null == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RevenuePointImplCopyWith<$Res>
    implements $RevenuePointCopyWith<$Res> {
  factory _$$RevenuePointImplCopyWith(
    _$RevenuePointImpl value,
    $Res Function(_$RevenuePointImpl) then,
  ) = __$$RevenuePointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, double amount});
}

/// @nodoc
class __$$RevenuePointImplCopyWithImpl<$Res>
    extends _$RevenuePointCopyWithImpl<$Res, _$RevenuePointImpl>
    implements _$$RevenuePointImplCopyWith<$Res> {
  __$$RevenuePointImplCopyWithImpl(
    _$RevenuePointImpl _value,
    $Res Function(_$RevenuePointImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RevenuePoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? date = null, Object? amount = null}) {
    return _then(
      _$RevenuePointImpl(
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        amount:
            null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RevenuePointImpl implements _RevenuePoint {
  const _$RevenuePointImpl({required this.date, required this.amount});

  factory _$RevenuePointImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevenuePointImplFromJson(json);

  @override
  final DateTime date;
  @override
  final double amount;

  @override
  String toString() {
    return 'RevenuePoint(date: $date, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevenuePointImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, date, amount);

  /// Create a copy of RevenuePoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RevenuePointImplCopyWith<_$RevenuePointImpl> get copyWith =>
      __$$RevenuePointImplCopyWithImpl<_$RevenuePointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevenuePointImplToJson(this);
  }
}

abstract class _RevenuePoint implements RevenuePoint {
  const factory _RevenuePoint({
    required final DateTime date,
    required final double amount,
  }) = _$RevenuePointImpl;

  factory _RevenuePoint.fromJson(Map<String, dynamic> json) =
      _$RevenuePointImpl.fromJson;

  @override
  DateTime get date;
  @override
  double get amount;

  /// Create a copy of RevenuePoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RevenuePointImplCopyWith<_$RevenuePointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdminDashboard _$AdminDashboardFromJson(Map<String, dynamic> json) {
  return _AdminDashboard.fromJson(json);
}

/// @nodoc
mixin _$AdminDashboard {
  @JsonKey(name: 'total_orders')
  int get totalOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'pending_orders')
  int get pendingOrders => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_revenue')
  double get totalRevenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_customers')
  int get totalCustomers => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_products')
  List<TopProduct> get topProducts => throw _privateConstructorUsedError;
  @JsonKey(name: 'revenue_chart')
  List<RevenuePoint> get revenueChart => throw _privateConstructorUsedError;

  /// Serializes this AdminDashboard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminDashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminDashboardCopyWith<AdminDashboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminDashboardCopyWith<$Res> {
  factory $AdminDashboardCopyWith(
    AdminDashboard value,
    $Res Function(AdminDashboard) then,
  ) = _$AdminDashboardCopyWithImpl<$Res, AdminDashboard>;
  @useResult
  $Res call({
    @JsonKey(name: 'total_orders') int totalOrders,
    @JsonKey(name: 'pending_orders') int pendingOrders,
    @JsonKey(name: 'total_revenue') double totalRevenue,
    @JsonKey(name: 'total_customers') int totalCustomers,
    @JsonKey(name: 'top_products') List<TopProduct> topProducts,
    @JsonKey(name: 'revenue_chart') List<RevenuePoint> revenueChart,
  });
}

/// @nodoc
class _$AdminDashboardCopyWithImpl<$Res, $Val extends AdminDashboard>
    implements $AdminDashboardCopyWith<$Res> {
  _$AdminDashboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminDashboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalOrders = null,
    Object? pendingOrders = null,
    Object? totalRevenue = null,
    Object? totalCustomers = null,
    Object? topProducts = null,
    Object? revenueChart = null,
  }) {
    return _then(
      _value.copyWith(
            totalOrders:
                null == totalOrders
                    ? _value.totalOrders
                    : totalOrders // ignore: cast_nullable_to_non_nullable
                        as int,
            pendingOrders:
                null == pendingOrders
                    ? _value.pendingOrders
                    : pendingOrders // ignore: cast_nullable_to_non_nullable
                        as int,
            totalRevenue:
                null == totalRevenue
                    ? _value.totalRevenue
                    : totalRevenue // ignore: cast_nullable_to_non_nullable
                        as double,
            totalCustomers:
                null == totalCustomers
                    ? _value.totalCustomers
                    : totalCustomers // ignore: cast_nullable_to_non_nullable
                        as int,
            topProducts:
                null == topProducts
                    ? _value.topProducts
                    : topProducts // ignore: cast_nullable_to_non_nullable
                        as List<TopProduct>,
            revenueChart:
                null == revenueChart
                    ? _value.revenueChart
                    : revenueChart // ignore: cast_nullable_to_non_nullable
                        as List<RevenuePoint>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminDashboardImplCopyWith<$Res>
    implements $AdminDashboardCopyWith<$Res> {
  factory _$$AdminDashboardImplCopyWith(
    _$AdminDashboardImpl value,
    $Res Function(_$AdminDashboardImpl) then,
  ) = __$$AdminDashboardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'total_orders') int totalOrders,
    @JsonKey(name: 'pending_orders') int pendingOrders,
    @JsonKey(name: 'total_revenue') double totalRevenue,
    @JsonKey(name: 'total_customers') int totalCustomers,
    @JsonKey(name: 'top_products') List<TopProduct> topProducts,
    @JsonKey(name: 'revenue_chart') List<RevenuePoint> revenueChart,
  });
}

/// @nodoc
class __$$AdminDashboardImplCopyWithImpl<$Res>
    extends _$AdminDashboardCopyWithImpl<$Res, _$AdminDashboardImpl>
    implements _$$AdminDashboardImplCopyWith<$Res> {
  __$$AdminDashboardImplCopyWithImpl(
    _$AdminDashboardImpl _value,
    $Res Function(_$AdminDashboardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminDashboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalOrders = null,
    Object? pendingOrders = null,
    Object? totalRevenue = null,
    Object? totalCustomers = null,
    Object? topProducts = null,
    Object? revenueChart = null,
  }) {
    return _then(
      _$AdminDashboardImpl(
        totalOrders:
            null == totalOrders
                ? _value.totalOrders
                : totalOrders // ignore: cast_nullable_to_non_nullable
                    as int,
        pendingOrders:
            null == pendingOrders
                ? _value.pendingOrders
                : pendingOrders // ignore: cast_nullable_to_non_nullable
                    as int,
        totalRevenue:
            null == totalRevenue
                ? _value.totalRevenue
                : totalRevenue // ignore: cast_nullable_to_non_nullable
                    as double,
        totalCustomers:
            null == totalCustomers
                ? _value.totalCustomers
                : totalCustomers // ignore: cast_nullable_to_non_nullable
                    as int,
        topProducts:
            null == topProducts
                ? _value._topProducts
                : topProducts // ignore: cast_nullable_to_non_nullable
                    as List<TopProduct>,
        revenueChart:
            null == revenueChart
                ? _value._revenueChart
                : revenueChart // ignore: cast_nullable_to_non_nullable
                    as List<RevenuePoint>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminDashboardImpl implements _AdminDashboard {
  const _$AdminDashboardImpl({
    @JsonKey(name: 'total_orders') required this.totalOrders,
    @JsonKey(name: 'pending_orders') required this.pendingOrders,
    @JsonKey(name: 'total_revenue') required this.totalRevenue,
    @JsonKey(name: 'total_customers') required this.totalCustomers,
    @JsonKey(name: 'top_products') required final List<TopProduct> topProducts,
    @JsonKey(name: 'revenue_chart')
    required final List<RevenuePoint> revenueChart,
  }) : _topProducts = topProducts,
       _revenueChart = revenueChart;

  factory _$AdminDashboardImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminDashboardImplFromJson(json);

  @override
  @JsonKey(name: 'total_orders')
  final int totalOrders;
  @override
  @JsonKey(name: 'pending_orders')
  final int pendingOrders;
  @override
  @JsonKey(name: 'total_revenue')
  final double totalRevenue;
  @override
  @JsonKey(name: 'total_customers')
  final int totalCustomers;
  final List<TopProduct> _topProducts;
  @override
  @JsonKey(name: 'top_products')
  List<TopProduct> get topProducts {
    if (_topProducts is EqualUnmodifiableListView) return _topProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topProducts);
  }

  final List<RevenuePoint> _revenueChart;
  @override
  @JsonKey(name: 'revenue_chart')
  List<RevenuePoint> get revenueChart {
    if (_revenueChart is EqualUnmodifiableListView) return _revenueChart;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_revenueChart);
  }

  @override
  String toString() {
    return 'AdminDashboard(totalOrders: $totalOrders, pendingOrders: $pendingOrders, totalRevenue: $totalRevenue, totalCustomers: $totalCustomers, topProducts: $topProducts, revenueChart: $revenueChart)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminDashboardImpl &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.pendingOrders, pendingOrders) ||
                other.pendingOrders == pendingOrders) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalCustomers, totalCustomers) ||
                other.totalCustomers == totalCustomers) &&
            const DeepCollectionEquality().equals(
              other._topProducts,
              _topProducts,
            ) &&
            const DeepCollectionEquality().equals(
              other._revenueChart,
              _revenueChart,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalOrders,
    pendingOrders,
    totalRevenue,
    totalCustomers,
    const DeepCollectionEquality().hash(_topProducts),
    const DeepCollectionEquality().hash(_revenueChart),
  );

  /// Create a copy of AdminDashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminDashboardImplCopyWith<_$AdminDashboardImpl> get copyWith =>
      __$$AdminDashboardImplCopyWithImpl<_$AdminDashboardImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminDashboardImplToJson(this);
  }
}

abstract class _AdminDashboard implements AdminDashboard {
  const factory _AdminDashboard({
    @JsonKey(name: 'total_orders') required final int totalOrders,
    @JsonKey(name: 'pending_orders') required final int pendingOrders,
    @JsonKey(name: 'total_revenue') required final double totalRevenue,
    @JsonKey(name: 'total_customers') required final int totalCustomers,
    @JsonKey(name: 'top_products') required final List<TopProduct> topProducts,
    @JsonKey(name: 'revenue_chart')
    required final List<RevenuePoint> revenueChart,
  }) = _$AdminDashboardImpl;

  factory _AdminDashboard.fromJson(Map<String, dynamic> json) =
      _$AdminDashboardImpl.fromJson;

  @override
  @JsonKey(name: 'total_orders')
  int get totalOrders;
  @override
  @JsonKey(name: 'pending_orders')
  int get pendingOrders;
  @override
  @JsonKey(name: 'total_revenue')
  double get totalRevenue;
  @override
  @JsonKey(name: 'total_customers')
  int get totalCustomers;
  @override
  @JsonKey(name: 'top_products')
  List<TopProduct> get topProducts;
  @override
  @JsonKey(name: 'revenue_chart')
  List<RevenuePoint> get revenueChart;

  /// Create a copy of AdminDashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminDashboardImplCopyWith<_$AdminDashboardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
