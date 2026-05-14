import 'package:car_care/core/errors/filuar.dart';
import 'package:dartz/dartz.dart';
import '../entities/statistics_entity.dart';

abstract class ICarWasherStatisticsRepository {
  Future<Either<Failure, StatisticsEntity>> getStatistics();
}