import 'package:car_care/features/fuel_provider_management/domain/entities/fuel_provider_management_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';

abstract class IFuelProviderRepository {
  Future<Either<Failure, List<FuelProviderEntity>>> getFuelProviders({required String status});
  Future<Either<Failure, FuelProviderEntity>> getFuelProvider(int id);
  Future<Either<Failure, FuelProviderEntity>> approveFuelProvider(int id);
  Future<Either<Failure, FuelProviderEntity>> rejectFuelProvider(int id, String reason);
  Future<Either<Failure, FuelProviderEntity>> suspendFuelProvider(int id);
  Future<Either<Failure, FuelProviderEntity>> reactivateFuelProvider(int id);
}