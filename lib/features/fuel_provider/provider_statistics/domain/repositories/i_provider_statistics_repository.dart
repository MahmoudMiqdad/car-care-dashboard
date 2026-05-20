import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';
import '../entities/provider_statistics_entity.dart';

abstract class IProviderStatisticsRepository {

  Future<Either<Failure, ProviderStatisticsEntity>> providerStatistics(Map<String, dynamic> params);

}
