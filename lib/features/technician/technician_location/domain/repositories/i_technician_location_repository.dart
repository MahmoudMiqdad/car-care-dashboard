import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/technician/technician_location/domain/entities/technician_location_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ITechnicianLocationRepository {
  Future<Either<Failure, Unit>> updateLocation({
    required double lat,
    required double lng,
    int? sosId,
  });

  Future<Either<Failure, TechnicianLocationEntity>> shareLocation({
    required int sosId,
    required double lat,
    required double lng,
  });
}