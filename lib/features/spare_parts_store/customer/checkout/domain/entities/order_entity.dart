import 'package:car_care/features/spare_parts_store/customer/checkout/domain/entities/order_item_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/domain/entities/shop_entity.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  const OrderEntity({
    required this.id,
    required this.shop,
    required this.items,
    required this.totalPrice,
    required this.status,
    required this.statusText,
    required this.deliveryAddressNote,
    required this.customerLatitude,
    required this.customerLongitude,
    required this.createdAt,
    required this.canCancel,
  });

  final int id;
  final ShopEntity shop;
  final List<OrderItemEntity> items;
  final double totalPrice;
  final String status;
  final String statusText;
  final String? deliveryAddressNote;
  final double? customerLatitude;
  final double? customerLongitude;
  final DateTime? createdAt;
  final bool canCancel;

  @override
  List<Object?> get props => [
    id,
    shop,
    items,
    totalPrice,
    status,
    statusText,
    deliveryAddressNote,
    customerLatitude,
    customerLongitude,
    createdAt,
    canCancel,
  ];
}
