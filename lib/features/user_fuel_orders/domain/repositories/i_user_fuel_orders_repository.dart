import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';
import '../entities/user_fuel_orders_entity.dart';

abstract class IUserFuelOrdersRepository {

  Future<Either<Failure, UserFuelOrdersEntity>> userFuelOrders(Map<String, dynamic> params);

}
