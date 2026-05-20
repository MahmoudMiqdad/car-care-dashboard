import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';
import '../entities/provider_order_entity.dart';

abstract class IProviderOrderRepository {

  Future<Either<Failure, ProviderOrderEntity>> providerOrder(Map<String, dynamic> params);

}
