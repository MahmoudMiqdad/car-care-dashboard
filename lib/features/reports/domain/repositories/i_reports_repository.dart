// lib/features/reports/domain/repositories/i_reports_repository.dart
import 'package:car_care/features/reports/domain/entities/reports_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';

abstract class IReportsRepository {
  Future<Either<Failure, OverviewReportEntity>> getOverviewReport({
    String? from,
    String? to,
    String? providerType,
    String? status,
  });

  Future<Either<Failure, OperationsReportEntity>> getOperationsReport({
    String? from,
    String? to,
    String? operationType,
    String? status,
    String? groupBy,
  });

  Future<Either<Failure, ProvidersReportEntity>> getProvidersReport({
    String? providerType,
    String? providerStatus,
    String? billingStatus,
  });

  Future<Either<Failure, FinancialReportEntity>> getFinancialReport({
    String? from,
    String? to,
    String? providerType,
    String? groupBy,
  });

  Future<Either<Failure, BillingReportEntity>> getBillingReport({
    String? from,
    String? to,
    String? providerType,
    String? status,
  });

    Future<Either<Failure, AdvertisementsSummaryEntity>> getAdvertisementsReport({
      String? from,
      String? to,
      String? placement,
      bool? isActive,
    });
}