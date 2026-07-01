import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/spare_parts_store/customer/checkout/domain/entities/order_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ICustomerOrdersRepository {
  Future<Either<Failure, OrderEntity>> getOrderDetails(int orderId);
}
