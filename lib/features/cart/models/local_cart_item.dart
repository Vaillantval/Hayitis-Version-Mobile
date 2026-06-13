// lib/features/cart/models/local_cart_item.dart
import 'dart:convert';

class LocalCartItem {
  final int productId;
  final String name;
  final double price;
  final String currency;
  final String? imageUrl;
  final int quantity;

  const LocalCartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.currency,
    this.imageUrl,
    required this.quantity,
  });

  LocalCartItem copyWith({int? quantity}) => LocalCartItem(
    productId: productId,
    name: name,
    price: price,
    currency: currency,
    imageUrl: imageUrl,
    quantity: quantity ?? this.quantity,
  );

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'name': name,
    'price': price,
    'currency': currency,
    'imageUrl': imageUrl,
    'quantity': quantity,
  };

  factory LocalCartItem.fromJson(Map<String, dynamic> json) => LocalCartItem(
    productId: json['productId'] as int,
    name: json['name'] as String,
    price: (json['price'] as num).toDouble(),
    currency: json['currency'] as String,
    imageUrl: json['imageUrl'] as String?,
    quantity: json['quantity'] as int,
  );

  static List<LocalCartItem> decodeList(String json) {
    final list = jsonDecode(json) as List;
    return list.map((e) => LocalCartItem.fromJson(e as Map<String, dynamic>)).toList();
  }

  static String encodeList(List<LocalCartItem> items) =>
      jsonEncode(items.map((e) => e.toJson()).toList());
}
