import 'package:car_care/features/spare_parts_store/customer/checkout/domain/entities/order_entity.dart';

abstract class OrderDetailsState {}

class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoading extends OrderDetailsState {}

class OrderDetailsLoaded extends OrderDetailsState {
  OrderDetailsLoaded(
    this.order, {
    this.isCancelling = false,
    this.cancelError,
  });

  final OrderEntity order;
  final bool isCancelling;
  final String? cancelError;
}

class OrderDetailsError extends OrderDetailsState {
  OrderDetailsError(this.message);

  final String message;
}
