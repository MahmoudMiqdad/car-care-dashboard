import 'package:car_care/features/spare_parts_store/customer/checkout/domain/entities/order_entity.dart';

abstract class CustomerOrdersState {}

class CustomerOrdersInitial extends CustomerOrdersState {}

class CustomerOrdersLoading extends CustomerOrdersState {}

class CustomerOrdersLoaded extends CustomerOrdersState {
  CustomerOrdersLoaded(
    this.orders, {
    this.activeStatus,
    this.cancellingIds = const {},
    this.actionError,
  });

  final List<OrderEntity> orders;
  final String? activeStatus;
  final Set<int> cancellingIds;
  final String? actionError;
}

class CustomerOrdersEmpty extends CustomerOrdersState {
  CustomerOrdersEmpty(this.activeStatus);

  final String? activeStatus;
}

class CustomerOrdersError extends CustomerOrdersState {
  CustomerOrdersError(this.message);

  final String message;
}
