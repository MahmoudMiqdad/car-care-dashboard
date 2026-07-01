import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/spare_parts_store/customer/checkout/data/data_sources/checkout_remote_data_source.dart';
import 'package:car_care/features/spare_parts_store/customer/checkout/domain/entities/order_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/checkout/domain/repositories/i_checkout_repository.dart';
import 'package:dartz/dartz.dart';

class CheckoutRepositoryImpl implements ICheckoutRepository {
  const CheckoutRepositoryImpl(this._remote);
  final CheckoutRemoteDataSource _remote;

  @override
  Future<Either<Failure, OrderEntity>> createOrder({
    required double latitude,
    required double longitude,
    required String addressNote,
  }) async {
    try {
      final order = await _remote.createOrder(
        latitude: latitude,
        longitude: longitude,
        addressNote: addressNote,
      );
      return Right(order);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء إنشاء الطلب'));
    }
  }
}
