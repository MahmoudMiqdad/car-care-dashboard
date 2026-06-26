import 'package:car_care/core/errors/filuar.dart';
import 'package:dartz/dartz.dart';

abstract class IShareFuelProviderLocationRepository {
  Future<Either<Failure, void>> shareLocation({
    required int orderId,
    required double lat,
    required double lng,
  });
}