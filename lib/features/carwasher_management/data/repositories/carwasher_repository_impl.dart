
import 'package:car_care/features/carwasher_management/data/data_sources/carwasher_management_remote_data_source.dart';
import 'package:car_care/features/carwasher_management/data/models/carwasher_model.dart';

import 'package:car_care/features/carwasher_management/domain/entities/carwasher_management_entity.dart';
import 'package:car_care/features/carwasher_management/domain/repositories/i_carwasher_management_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';

class CarwasherRepositoryImpl implements ICarwasherRepository {
  final CarwasherRemoteDataSource _remote;
  CarwasherRepositoryImpl(this._remote);

  CarwasherEntity _mapCarwasher(CarwasherData? d) => CarwasherEntity(
        id: d?.id,
        shopName: d?.shopName,
        phone: d?.phone,
        city: d?.city,
        address: d?.address,
        logo: d?.logo,
        services: d?.services ?? const [],
        servicePrices: d?.servicePrices ?? const {},
        workingHours: d?.workingHours ?? const {},
        description: d?.description,
        isAvailable: d?.isAvailable,
        isVerified: d?.isVerified,
        status: d?.status,
        rejectionReason: d?.rejectionReason,
        approvedAt: d?.approvedAt,
        rejectedAt: d?.rejectedAt,
        suspendedAt: d?.suspendedAt,
        averageRating: d?.averageRating,
        ratingsCount: d?.ratingsCount,
        ratingStars: d?.ratingStars,
        createdAt: d?.createdAt,
        user: d?.user != null
            ? CarwasherUserEntity(
                id: d!.user!.id,
                name: d.user!.name,
                email: d.user!.email,
              )
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
  Future<Either<Failure, List<CarwasherEntity>>> getCarwashers({required String status}) =>
      _call(() async =>
          (await _remote.getCarwashers(status: status)).data.map(_mapCarwasher).toList());

  @override
  Future<Either<Failure, CarwasherEntity>> getCarwasher(int id) =>
      _call(() async => _mapCarwasher((await _remote.getCarwasher(id)).data));

  @override
  Future<Either<Failure, CarwasherEntity>> approveCarwasher(int id) =>
      _call(() async => _mapCarwasher((await _remote.approveCarwasher(id)).data));

  @override
  Future<Either<Failure, CarwasherEntity>> rejectCarwasher(int id, String reason) =>
      _call(() async => _mapCarwasher((await _remote.rejectCarwasher(id, reason)).data));

  @override
  Future<Either<Failure, CarwasherEntity>> suspendCarwasher(int id) =>
      _call(() async => _mapCarwasher((await _remote.suspendCarwasher(id)).data));

  @override
  Future<Either<Failure, CarwasherEntity>> reactivateCarwasher(int id) =>
      _call(() async => _mapCarwasher((await _remote.reactivateCarwasher(id)).data));
}