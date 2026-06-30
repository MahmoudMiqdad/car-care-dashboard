// كيان سلة المشتريات الكاملة (العناصر + الإجمالي)
import 'package:car_care/features/spare_parts_store/customer/cart/domain/entities/cart_item_entity.dart';
import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  const CartEntity({required this.items, required this.total});

  final List<CartItemEntity> items;
  final double total;

  @override
  List<Object?> get props => [items, total];
}
