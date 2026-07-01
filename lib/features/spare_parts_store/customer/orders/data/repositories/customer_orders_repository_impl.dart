import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/spare_parts_store/customer/checkout/domain/entities/order_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/orders/data/data_sources/customer_orders_remote_data_source.dart';
import 'package:car_care/features/spare_parts_store/customer/orders/domain/repositories/i_customer_orders_repository.dart';
import 'package:dartz/dartz.dart';

class CustomerOrdersRepositoryImpl implements ICustomerOrdersRepository {
  const CustomerOrdersRepositoryImpl(this._remote);
  final CustomerOrdersRemoteDataSource _remote;

  @override
  Future<Either<Failure, OrderEntity>> getOrderDetails(int orderId) async {
    try {
      final order = await _remote.getOrderDetails(orderId);
      return Right(order);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء جلب تفاصيل الطلب'));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders({String? status}) async {
    try {
      final orders = await _remote.getOrders(status: status);
      return Right(orders);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء جلب الطلبات'));
    }
  }

  @override
  Future<Either<Failure, String>> cancelOrder(
    int orderId,
    String reason,
  ) async {
    try {
      final message = await _remote.cancelOrder(orderId, reason);
      return Right(message);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء إلغاء الطلب'));
    }
  }
}
