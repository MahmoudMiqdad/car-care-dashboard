import 'package:car_care/features/spare_parts_store/customer/checkout/domain/entities/order_entity.dart';

abstract class CreateOrderState {}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderLoading extends CreateOrderState {}

class CreateOrderSuccess extends CreateOrderState {
  CreateOrderSuccess(this.order);

  final OrderEntity order;
}

class CreateOrderError extends CreateOrderState {
  CreateOrderError(this.message);

  final String message;
}
