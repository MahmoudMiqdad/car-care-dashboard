import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';
import '../entities/share_location_fuel_entity.dart';

abstract class IShareLocationFuelRepository {

  Future<Either<Failure, ShareLocationFuelEntity>> shareLocationFuel(Map<String, dynamic> params);

}
