import 'package:car_care/features/spare_parts_store/customer/checkout/domain/entities/order_item_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/products/data/models/product_model.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.product,
    required super.quantity,
    required super.price,
    required super.subtotal,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: _toInt(json['id']),
      product: ProductModel.fromJson(
        (json['product'] as Map).cast<String, dynamic>(),
      ),
      quantity: _toInt(json['quantity']),
      price: _toDouble(json['price']),
      subtotal: _toDouble(json['subtotal']),
    );
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
