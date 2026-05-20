import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';
import '../entities/provider_available_orders_entity.dart';

abstract class IProviderAvailableOrdersRepository {

  Future<Either<Failure, ProviderAvailableOrdersEntity>> providerAvailableOrders(Map<String, dynamic> params);

}
