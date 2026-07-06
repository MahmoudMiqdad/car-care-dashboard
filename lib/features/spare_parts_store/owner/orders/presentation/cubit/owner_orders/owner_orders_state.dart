// حالات قائمة طلبات متجر المالك.
import 'package:car_care/features/spare_parts_store/customer/checkout/domain/entities/order_entity.dart';

abstract class OwnerOrdersState {}

class OwnerOrdersInitial extends OwnerOrdersState {}

class OwnerOrdersLoading extends OwnerOrdersState {}

class OwnerOrdersLoaded extends OwnerOrdersState {
  OwnerOrdersLoaded(this.orders);

  final List<OrderEntity> orders;
}

class OwnerOrdersEmpty extends OwnerOrdersState {}

class OwnerOrdersError extends OwnerOrdersState {
  OwnerOrdersError(this.message);

  final String message;
}
