import 'package:car_care/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';

abstract class IDashboardRepository {
  Future<Either<Failure, DashboardSummaryEntity>> getDashboardSummary();
  Future<Either<Failure, DashboardOperationsEntity>> getDashboardOperations({
    String? period,
    String? groupBy,
    String? from,
    String? to,
  });
  Future<Either<Failure, DashboardRevenueEntity>> getDashboardRevenue({String? from, String? to});
  Future<Either<Failure, List<AdvertisementEntity>>> getActiveAdvertisements();
}