import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/technician/technician_location/data/data_sources/technician_location_remote_data_source.dart';
import 'package:car_care/features/technician/technician_location/domain/entities/technician_location_entity.dart';
import 'package:car_care/features/technician/technician_location/domain/repositories/i_technician_location_repository.dart';
import 'package:dartz/dartz.dart';

class TechnicianLocationRepositoryImpl
    implements ITechnicianLocationRepository {
  final TechnicianLocationRemoteDataSource _remote;

  TechnicianLocationRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, Unit>> updateLocation({
    required double lat,
    required double lng,
    int? sosId,
  }) async {
    try {
      await _remote.updateLocation(lat: lat, lng: lng);

      if (sosId != null) {
        await _remote.shareLocation(
          sosId: sosId,
          lat: lat,
          lng: lng,
        );
      }

      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TechnicianLocationEntity>> shareLocation({
    required int sosId,
    required double lat,
    required double lng,
  }) async {
    try {
      final result = await _remote.shareLocation(
        sosId: sosId,
        lat: lat,
        lng: lng,
      );

      return Right(
        TechnicianLocationEntity(
          lat: result.lat ?? 0,
          lng: result.lng ?? 0,
        ),
      );
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}