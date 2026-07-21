// واجهة مستودع طلبات متجر المالك.
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/spare_parts_store/customer/checkout/domain/entities/order_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IOwnerOrdersRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, OrderEntity>> getOrderDetails(int orderId);
  Future<Either<Failure, OrderEntity>> acceptOrder(int orderId);
  Future<Either<Failure, OrderEntity>> rejectOrder(int orderId, String reason);
  Future<Either<Failure, OrderEntity>> updateStatus(
    int orderId,
    String status,
    String notes,
  );
}
