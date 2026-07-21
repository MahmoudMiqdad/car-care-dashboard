import 'package:car_care/features/spare_parts_store/customer/checkout/data/models/order_item_model.dart';
import 'package:car_care/features/spare_parts_store/customer/checkout/domain/entities/order_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/data/models/shop_model.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.shop,
    required super.items,
    required super.totalPrice,
    required super.status,
    required super.statusText,
    required super.deliveryAddressNote,
    required super.customerLatitude,
    required super.customerLongitude,
    required super.createdAt,
    required super.canCancel,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: _toInt(json['id']),
      shop: ShopModel.fromJson((json['shop'] as Map).cast<String, dynamic>()),
      items: (json['items'] is List ? json['items'] as List : const [])
          .whereType<Map>()
          .map((e) => OrderItemModel.fromJson(e.cast<String, dynamic>()))
          .toList(),
      totalPrice: _toDouble(json['total_price']),
      status: (json['status'] ?? '').toString(),
      statusText: (json['status_text'] ?? '').toString(),
      deliveryAddressNote: json['delivery_address_note']?.toString(),
      customerLatitude: json['customer_latitude'] == null
          ? null
          : _toDouble(json['customer_latitude']),
      customerLongitude: json['customer_longitude'] == null
          ? null
          : _toDouble(json['customer_longitude']),
      createdAt: DateTime.tryParse((json['created_at'] ?? '').toString()),
      canCancel: json['can_cancel'] == true,
    );
  }

  static List<OrderModel> listFromResponse(Map<String, dynamic> response) {
    final data = response['data'];

    final List<dynamic> items;
    if (data is List) {
      items = data;
    } else if (data is Map && data['data'] is List) {
      items = data['data'] as List;
    } else {
      items = const [];
    }

    return items
        .whereType<Map>()
        .map((e) => OrderModel.fromJson(e.cast<String, dynamic>()))
        .toList();
  }

  static int _toInt(dynamic v, {int fallback = 0}) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? fallback;
    return fallback;
  }

  static double _toDouble(dynamic v, {double fallback = 0}) {
    if (v is double) return v;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? fallback;
    return fallback;
  }
}
