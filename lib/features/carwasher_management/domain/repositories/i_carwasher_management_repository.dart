import 'package:car_care/features/carwasher_management/domain/entities/carwasher_management_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';

abstract class ICarwasherRepository {
  Future<Either<Failure, List<CarwasherEntity>>> getCarwashers({required String status});
  Future<Either<Failure, CarwasherEntity>> getCarwasher(int id);
  Future<Either<Failure, CarwasherEntity>> approveCarwasher(int id);
  Future<Either<Failure, CarwasherEntity>> rejectCarwasher(int id, String reason);
  Future<Either<Failure, CarwasherEntity>> suspendCarwasher(int id);
  Future<Either<Failure, CarwasherEntity>> reactivateCarwasher(int id);
}