import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';
import '../entities/user_fuel_entity.dart';

abstract class IUserFuelRepository {

  Future<Either<Failure, UserFuelEntity>> userFuel(Map<String, dynamic> params);

}
