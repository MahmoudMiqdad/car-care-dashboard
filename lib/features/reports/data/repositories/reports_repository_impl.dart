// lib/features/reports/data/repositories/reports_repository_impl.dart
import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/reports/data/data_sources/reports_remote_data_source.dart';
import 'package:car_care/features/reports/data/models/reports_models.dart';
import 'package:car_care/features/reports/domain/entities/reports_entity.dart';

import 'package:car_care/features/reports/domain/repositories/i_reports_repository.dart';
import 'package:dartz/dartz.dart';

class ReportsRepositoryImpl implements IReportsRepository {
  final ReportsRemoteDataSource _remote;
  ReportsRepositoryImpl(this._remote);

  Future<Either<Failure, T>> _call<T>(Future<T> Function() fn) async {
    try {
      return Right(await fn());
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  ReportRangeEntity? _mapRange(ReportRangeModel? m) =>
      m == null ? null : ReportRangeEntity(from: m.from, to: m.to);

  OperationCountEntity _mapCount(OperationCountModel m) => OperationCountEntity(
        total: m.total,
        completed: m.completed,
        pending: m.pending,
        cancelled: m.cancelled,
        inProgress: m.inProgress,
      );

  RevenueSummaryEntity? _mapRevenue(RevenueSummaryModel? m) =>
      m == null ? null : RevenueSummaryEntity(bySource: m.bySource, notes: m.notes);

  BillingSummaryEntity? _mapBillingSummary(BillingSummaryModel? m) => m == null
      ? null
      : BillingSummaryEntity(
          issuedTotal: m.issuedTotal,
          paidTotal: m.paidTotal,
          unpaidTotal: m.unpaidTotal,
          overdueTotal: m.overdueTotal,
          commissionTotal: m.commissionTotal,
          subscriptionTotal: m.subscriptionTotal,
          totalAmount: m.totalAmount,
        );

  AdEntity _mapAd(AdModel m) => AdEntity(
        id: m.id,
        title: m.title,
        placement: m.placement,
        isActive: m.isActive,
        imageUrl: m.imageUrl,
        createdAt: m.createdAt,
      );

  AdvertisementsSummaryEntity? _mapAdsSummary(AdvertisementsSummaryModel? m) => m == null
      ? null
      : AdvertisementsSummaryEntity(
          range: _mapRange(m.range),
          totalAds: m.totalAds,
          activeAds: m.activeAds,
          inactiveAds: m.inactiveAds,
          expiredAds: m.expiredAds,
          scheduledAds: m.scheduledAds,
          adsByPlacement: m.adsByPlacement,
          latestAds: m.latestAds.map(_mapAd).toList(),
        );

  @override
  Future<Either<Failure, OverviewReportEntity>> getOverviewReport({
    String? from,
    String? to,
    String? providerType,
    String? status,
  }) =>
      _call(() async {
        final res = await _remote.getOverview(from: from, to: to, providerType: providerType, status: status);
        final d = res.data;
        return OverviewReportEntity(
          range: _mapRange(d?.range),
          entities: d?.entities != null
              ? OverviewEntitiesEntity(
                  totalUsers: d!.entities!.totalUsers,
                  totalCustomers: d.entities!.totalCustomers,
                  totalProviders: d.entities!.totalProviders,
                  providersByType: d.entities!.providersByType,
                  providersByStatus: d.entities!.providersByStatus,
                )
              : null,
          operationsSummary: d?.operationsSummary.map((k, v) => MapEntry(k, _mapCount(v))) ?? {},
          revenueSummary: _mapRevenue(d?.revenueSummary),
          billingSummary: _mapBillingSummary(d?.billingSummary),
          advertisementsSummary: _mapAdsSummary(d?.advertisementsSummary),
        );
      });

  @override
  Future<Either<Failure, OperationsReportEntity>> getOperationsReport({
    String? from,
    String? to,
    String? operationType,
    String? status,
    String? groupBy,
  }) =>
      _call(() async {
        final res = await _remote.getOperations(
          from: from,
          to: to,
          operationType: operationType,
          status: status,
          groupBy: groupBy,
        );
        final d = res.data;
        return OperationsReportEntity(
          range: _mapRange(d?.range),
          groupBy: d?.groupBy,
          operations: d?.operations.map((k, v) => MapEntry(k, _mapCount(v))) ?? {},
        );
      });

  @override
  Future<Either<Failure, ProvidersReportEntity>> getProvidersReport({
    String? providerType,
    String? providerStatus,
    String? billingStatus,
  }) =>
      _call(() async {
        final res = await _remote.getProviders(
          providerType: providerType,
          providerStatus: providerStatus,
          billingStatus: billingStatus,
        );
        final d = res.data;
        return ProvidersReportEntity(
          countsByType: d?.countsByType ?? {},
          countsByProviderStatus: d?.countsByProviderStatus ?? {},
          countsByBillingStatus: d?.countsByBillingStatus ?? {},
          topProvidersByCompletedOperations: d?.topProvidersByCompletedOperations.map(
                (k, v) => MapEntry(
                  k,
                  v
                      .map((e) => TopProviderEntity(
                            providerId: e.providerId,
                            providerName: e.providerName,
                            completedCount: e.completedCount,
                          ))
                      .toList(),
                ),
              ) ??
              {},
          needingAction: d?.needingAction != null
              ? NeedingActionEntity(
                  pendingApproval: d!.needingAction!.pendingApproval,
                  overdueBillingCount: d.needingAction!.overdueBillingCount,
                  notConfiguredBillingCount: d.needingAction!.notConfiguredBillingCount,
                )
              : null,
        );
      });

  @override
  Future<Either<Failure, FinancialReportEntity>> getFinancialReport({
    String? from,
    String? to,
    String? providerType,
    String? groupBy,
  }) =>
      _call(() async {
        final res =
            await _remote.getFinancial(from: from, to: to, providerType: providerType, groupBy: groupBy);
        final d = res.data;
        return FinancialReportEntity(
          range: _mapRange(d?.range),
          groupBy: d?.groupBy,
          grossRevenue: _mapRevenue(d?.grossRevenue),
          billing: _mapBillingSummary(d?.billing),
        );
      });

  @override
  Future<Either<Failure, BillingReportEntity>> getBillingReport({
    String? from,
    String? to,
    String? providerType,
    String? status,
  }) =>
      _call(() async {
        final res = await _remote.getBilling(from: from, to: to, providerType: providerType, status: status);
        final d = res.data;
        return BillingReportEntity(
          range: _mapRange(d?.range),
          invoicesCount: d?.invoicesCount,
          draftCount: d?.draftCount,
          issuedCount: d?.issuedCount,
          overdueCount: d?.overdueCount,
          paidCount: d?.paidCount,
          cancelledCount: d?.cancelledCount,
          paidTotal: d?.paidTotal,
          unpaidTotal: d?.unpaidTotal,
          overdueTotal: d?.overdueTotal,
          averageInvoiceAmount: d?.averageInvoiceAmount,
          providersWithOverdueCount: d?.providersWithOverdueCount,
          latestInvoices: d?.latestInvoices
                  .map((e) => InvoiceEntity(
                        id: e.id,
                        providerId: e.providerId,
                        providerName: e.providerName,
                        amount: e.amount,
                        status: e.status,
                        issuedAt: e.issuedAt,
                        dueAt: e.dueAt,
                        paidAt: e.paidAt,
                      ))
                  .toList() ??
              [],
        );
      });

  @override
  Future<Either<Failure, AdvertisementsSummaryEntity>> getAdvertisementsReport({
    String? from,
    String? to,
    String? placement,
    bool? isActive,
  }) =>
      _call(() async {
        final res =
            await _remote.getAdvertisements(from: from, to: to, placement: placement, isActive: isActive);
        return _mapAdsSummary(res.data) ?? const AdvertisementsSummaryEntity();
      });
}