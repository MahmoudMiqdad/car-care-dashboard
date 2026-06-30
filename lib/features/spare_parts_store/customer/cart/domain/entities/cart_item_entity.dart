// كيان عنصر داخل سلة المشتريات
import 'package:car_care/features/spare_parts_store/customer/products/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  const CartItemEntity({
    required this.id,
    required this.product,
    required this.quantity,
    required this.subtotal,
    required this.addedAt,
  });

  final int id;
  final ProductEntity product;
  final int quantity;
  final double subtotal;
  final DateTime? addedAt;

  @override
  List<Object?> get props => [id, product, quantity, subtotal, addedAt];
}
