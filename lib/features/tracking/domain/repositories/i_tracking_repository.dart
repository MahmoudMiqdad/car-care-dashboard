import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';
import '../entities/tracking_entity.dart';

abstract class ITrackingRepository {

  Future<Either<Failure, TrackingEntity>> tracking(Map<String, dynamic> params);

}
