
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/user_fuel/domain/entities/user_fuel_order_entity.dart';
import 'package:car_care/features/user_fuel/domain/entities/user_fuel_track_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IUserFuelRepository {
  Future<Either<Failure, List<UserFuelOrderEntity>>> getAllOrders();
  Future<Either<Failure, UserFuelOrderEntity>> getOrder(int id);
  Future<Either<Failure, UserFuelOrderEntity>> addEmergencyOrder(
      Map<String, dynamic> data);
  Future<Either<Failure, void>> cancelOrder(int id, String reason);
  Future<Either<Failure, UserFuelTrackEntity>> trackOrder(int id);
}