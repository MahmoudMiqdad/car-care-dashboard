// تنفيذ مستودع طلبات المتجر.
import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/spare_parts_store/customer/checkout/domain/entities/order_entity.dart';
import 'package:car_care/features/spare_parts_store/owner/orders/data/data_sources/owner_orders_remote_data_source.dart';
import 'package:car_care/features/spare_parts_store/owner/orders/domain/repositories/i_owner_orders_repository.dart';
import 'package:dartz/dartz.dart';

class OwnerOrdersRepositoryImpl implements IOwnerOrdersRepository {
  const OwnerOrdersRepositoryImpl(this._dataSource);

  final OwnerOrdersRemoteDataSource _dataSource;

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    try {
      return Right(await _dataSource.getOrders());
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء جلب الطلبات'));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderDetails(int orderId) async {
    try {
      return Right(await _dataSource.getOrderDetails(orderId));
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء جلب تفاصيل الطلب'));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> acceptOrder(int orderId) async {
    try {
      return Right(await _dataSource.acceptOrder(orderId));
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء قبول الطلب'));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> rejectOrder(
    int orderId,
    String reason,
  ) async {
    try {
      return Right(await _dataSource.rejectOrder(orderId, reason));
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء رفض الطلب'));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> updateStatus(
    int orderId,
    String status,
    String notes,
  ) async {
    try {
      return Right(await _dataSource.updateStatus(orderId, status, notes));
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(
        Failure(message: 'حدث خطأ أثناء تحديث حالة الطلب'),
      );
    }
  }
}
