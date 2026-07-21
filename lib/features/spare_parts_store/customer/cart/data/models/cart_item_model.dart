// نموذج بيانات عنصر السلة القادم من API، يُحوَّل إلى CartItemEntity (يعيد استخدام ProductModel للمنتج المرفق)
import 'package:car_care/features/spare_parts_store/customer/cart/domain/entities/cart_item_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/products/data/models/product_model.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.id,
    required super.product,
    required super.quantity,
    required super.subtotal,
    required super.addedAt,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: _toInt(json['id']),
      product: ProductModel.fromJson(
        (json['product'] as Map).cast<String, dynamic>(),
      ),
      quantity: _toInt(json['quantity']),
      subtotal: _toDouble(json['subtotal']),
      addedAt: DateTime.tryParse((json['added_at'] ?? '').toString()),
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
