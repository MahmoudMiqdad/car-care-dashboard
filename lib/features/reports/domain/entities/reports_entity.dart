// lib/features/reports/domain/entities/reports_entities.dart

class ReportRangeEntity {
  final String? from;
  final String? to;
  const ReportRangeEntity({this.from, this.to});
}

class OperationCountEntity {
  final int? total;
  final int? completed;
  final int? pending;
  final int? cancelled;
  final int? inProgress;
  const OperationCountEntity({
    this.total,
    this.completed,
    this.pending,
    this.cancelled,
    this.inProgress,
  });
}

class RevenueSummaryEntity {
  final Map<String, num> bySource;
  final List<String> notes;
  const RevenueSummaryEntity({this.bySource = const {}, this.notes = const []});
}

class BillingSummaryEntity {
  final num? issuedTotal;
  final num? paidTotal;
  final num? unpaidTotal;
  final num? overdueTotal;
  final num? commissionTotal;
  final num? subscriptionTotal;
  final num? totalAmount;
  const BillingSummaryEntity({
    this.issuedTotal,
    this.paidTotal,
    this.unpaidTotal,
    this.overdueTotal,
    this.commissionTotal,
    this.subscriptionTotal,
    this.totalAmount,
  });
}

class AdEntity {
  final int? id;
  final String? title;
  final String? placement;
  final bool? isActive;
  final String? imageUrl;
  final String? createdAt;
  const AdEntity({
    this.id,
    this.title,
    this.placement,
    this.isActive,
    this.imageUrl,
    this.createdAt,
  });
}

class AdvertisementsSummaryEntity {
  final ReportRangeEntity? range;
  final int? totalAds;
  final int? activeAds;
  final int? inactiveAds;
  final int? expiredAds;
  final int? scheduledAds;
  final Map<String, int> adsByPlacement;
  final List<AdEntity> latestAds;
  const AdvertisementsSummaryEntity({
    this.range,
    this.totalAds,
    this.activeAds,
    this.inactiveAds,
    this.expiredAds,
    this.scheduledAds,
    this.adsByPlacement = const {},
    this.latestAds = const [],
  });
}

// ---------------- Overview ----------------

class OverviewEntitiesEntity {
  final int? totalUsers;
  final int? totalCustomers;
  final int? totalProviders;
  final Map<String, int> providersByType;
  final Map<String, Map<String, int>> providersByStatus;
  const OverviewEntitiesEntity({
    this.totalUsers,
    this.totalCustomers,
    this.totalProviders,
    this.providersByType = const {},
    this.providersByStatus = const {},
  });
}

class OverviewReportEntity {
  final ReportRangeEntity? range;
  final OverviewEntitiesEntity? entities;
  final Map<String, OperationCountEntity> operationsSummary;
  final RevenueSummaryEntity? revenueSummary;
  final BillingSummaryEntity? billingSummary;
  final AdvertisementsSummaryEntity? advertisementsSummary;
  const OverviewReportEntity({
    this.range,
    this.entities,
    this.operationsSummary = const {},
    this.revenueSummary,
    this.billingSummary,
    this.advertisementsSummary,
  });
}

// ---------------- Operations ----------------

class OperationsReportEntity {
  final ReportRangeEntity? range;
  final String? groupBy;
  final Map<String, OperationCountEntity> operations;
  const OperationsReportEntity({this.range, this.groupBy, this.operations = const {}});
}

// ---------------- Providers ----------------

class TopProviderEntity {
  final int? providerId;
  final String? providerName;
  final int? completedCount;
  const TopProviderEntity({this.providerId, this.providerName, this.completedCount});
}

class NeedingActionEntity {
  final int? pendingApproval;
  final int? overdueBillingCount;
  final int? notConfiguredBillingCount;
  const NeedingActionEntity({
    this.pendingApproval,
    this.overdueBillingCount,
    this.notConfiguredBillingCount,
  });
}

class ProvidersReportEntity {
  final Map<String, int> countsByType;
  final Map<String, Map<String, int>> countsByProviderStatus;
  final Map<String, int> countsByBillingStatus;
  final Map<String, List<TopProviderEntity>> topProvidersByCompletedOperations;
  final NeedingActionEntity? needingAction;
  const ProvidersReportEntity({
    this.countsByType = const {},
    this.countsByProviderStatus = const {},
    this.countsByBillingStatus = const {},
    this.topProvidersByCompletedOperations = const {},
    this.needingAction,
  });
}

// ---------------- Financial ----------------

class FinancialReportEntity {
  final ReportRangeEntity? range;
  final String? groupBy;
  final RevenueSummaryEntity? grossRevenue;
  final BillingSummaryEntity? billing;
  const FinancialReportEntity({this.range, this.groupBy, this.grossRevenue, this.billing});
}

// ---------------- Billing ----------------

class InvoiceEntity {
  final int? id;
  final int? providerId;
  final String? providerName;
  final num? amount;
  final String? status;
  final String? issuedAt;
  final String? dueAt;
  final String? paidAt;
  const InvoiceEntity({
    this.id,
    this.providerId,
    this.providerName,
    this.amount,
    this.status,
    this.issuedAt,
    this.dueAt,
    this.paidAt,
  });
}

class BillingReportEntity {
  final ReportRangeEntity? range;
  final int? invoicesCount;
  final int? draftCount;
  final int? issuedCount;
  final int? overdueCount;
  final int? paidCount;
  final int? cancelledCount;
  final num? paidTotal;
  final num? unpaidTotal;
  final num? overdueTotal;
  final num? averageInvoiceAmount;
  final int? providersWithOverdueCount;
  final List<InvoiceEntity> latestInvoices;
  const BillingReportEntity({
    this.range,
    this.invoicesCount,
    this.draftCount,
    this.issuedCount,
    this.overdueCount,
    this.paidCount,
    this.cancelledCount,
    this.paidTotal,
    this.unpaidTotal,
    this.overdueTotal,
    this.averageInvoiceAmount,
    this.providersWithOverdueCount,
    this.latestInvoices = const [],
  });
}