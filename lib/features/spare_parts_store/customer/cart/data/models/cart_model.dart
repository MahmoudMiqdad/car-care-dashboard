// محوّل استجابة سلة المشتريات الكاملة (عناصر + إجمالي) إلى CartEntity
import 'package:car_care/features/spare_parts_store/customer/cart/data/models/cart_item_model.dart';
import 'package:car_care/features/spare_parts_store/customer/cart/domain/entities/cart_entity.dart';

class CartModel {
  static CartEntity fromResponse(Map<String, dynamic> response) {
    final data = response['data'];

    List<dynamic> itemsJson = const [];
    num? total;

    if (data is List) {
      itemsJson = data;
      total = response['total'] is num ? response['total'] as num : null;
    } else if (data is Map) {
      if (data['data'] is List) {
        itemsJson = data['data'] as List;
      } else if (data['items'] is List) {
        itemsJson = data['items'] as List;
      }
      total = data['total'] is num
          ? data['total'] as num
          : (response['total'] is num ? response['total'] as num : null);
    }

    final items = itemsJson
        .whereType<Map>()
        .map((e) => CartItemModel.fromJson(e.cast<String, dynamic>()))
        .toList();

    final computedTotal =
        total?.toDouble() ??
        items.fold<double>(0, (sum, item) => sum + item.subtotal);

    return CartEntity(items: items, total: computedTotal);
  }
}
