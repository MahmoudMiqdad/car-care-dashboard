import 'package:car_care/features/spare_parts_store/customer/products/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  const OrderItemEntity({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
    required this.subtotal,
  });

  final int id;
  final ProductEntity product;
  final int quantity;
  final double price;
  final double subtotal;

  @override
  List<Object?> get props => [id, product, quantity, price, subtotal];
}
