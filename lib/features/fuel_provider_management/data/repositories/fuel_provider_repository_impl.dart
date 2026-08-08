import 'package:car_care/features/fuel_provider_management/data/data_sources/fuel_provider_management_remote_data_source.dart';
import 'package:car_care/features/fuel_provider_management/data/models/fuel_provider_model.dart';
import 'package:car_care/features/fuel_provider_management/domain/entities/fuel_provider_management_entity.dart';
import 'package:car_care/features/fuel_provider_management/domain/repositories/i_fuel_provider_management_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';

class FuelProviderRepositoryImpl implements IFuelProviderRepository {
  final FuelProviderRemoteDataSource _remote;
  FuelProviderRepositoryImpl(this._remote);

  FuelProviderEntity _mapFuelProvider(FuelProviderData? d) => FuelProviderEntity(
        id: d?.id,
        companyName: d?.companyName,
        phone: d?.phone,
        city: d?.city,
        address: d?.address,
        latitude: d?.latitude,
        longitude: d?.longitude,
        fuelTypes: d?.fuelTypes ?? const [],
        prices: d?.prices ?? const {},
        isAvailable: d?.isAvailable,
        isVerified: d?.isVerified,
        status: d?.status,
        rejectionReason: d?.rejectionReason,
        approvedAt: d?.approvedAt,
        rejectedAt: d?.rejectedAt,
        suspendedAt: d?.suspendedAt,
        createdAt: d?.createdAt,
        user: d?.user != null
            ? FuelProviderUserEntity(id: d!.user!.id, name: d.user!.name, email: d.user!.email)
            : null,
      );

  Future<Either<Failure, T>> _call<T>(Future<T> Function() fn) async {
    try {
      return Right(await fn());
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FuelProviderEntity>>> getFuelProviders({required String status}) =>
      _call(() async =>
          (await _remote.getFuelProviders(status: status)).data.map(_mapFuelProvider).toList());

  @override
  Future<Either<Failure, FuelProviderEntity>> getFuelProvider(int id) =>
      _call(() async => _mapFuelProvider((await _remote.getFuelProvider(id)).data));

  @override
  Future<Either<Failure, FuelProviderEntity>> approveFuelProvider(int id) =>
      _call(() async => _mapFuelProvider((await _remote.approveFuelProvider(id)).data));

  @override
  Future<Either<Failure, FuelProviderEntity>> rejectFuelProvider(int id, String reason) =>
      _call(() async => _mapFuelProvider((await _remote.rejectFuelProvider(id, reason)).data));

  @override
  Future<Either<Failure, FuelProviderEntity>> suspendFuelProvider(int id) =>
      _call(() async => _mapFuelProvider((await _remote.suspendFuelProvider(id)).data));

  @override
  Future<Either<Failure, FuelProviderEntity>> reactivateFuelProvider(int id) =>
      _call(() async => _mapFuelProvider((await _remote.reactivateFuelProvider(id)).data));
}