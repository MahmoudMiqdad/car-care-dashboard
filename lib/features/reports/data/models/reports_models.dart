

class ReportRangeModel {
  final String? from;
  final String? to;

  ReportRangeModel({this.from, this.to});

  factory ReportRangeModel.fromJson(Map<String, dynamic> json) => ReportRangeModel(
        from: json['from'],
        to: json['to'],
      );
}

class OperationCountModel {
  final int? total;
  final int? completed;
  final int? pending;
  final int? cancelled;
  final int? inProgress;

  OperationCountModel({
    this.total,
    this.completed,
    this.pending,
    this.cancelled,
    this.inProgress,
  });

  factory OperationCountModel.fromJson(Map<String, dynamic> json) => OperationCountModel(
        total: json['total'],
        completed: json['completed'],
        pending: json['pending'],
        cancelled: json['cancelled'],
        inProgress: json['in_progress'],
      );
}

class RevenueSummaryModel {
  final Map<String, num> bySource;
  final List<String> notes;

  RevenueSummaryModel({this.bySource = const {}, this.notes = const []});

  factory RevenueSummaryModel.fromJson(Map<String, dynamic> json) => RevenueSummaryModel(
        bySource: json['by_source'] != null
            ? Map<String, num>.from(json['by_source'])
            : {},
        notes: json['notes'] != null ? List<String>.from(json['notes']) : [],
      );
}

class BillingSummaryModel {
  final num? issuedTotal;
  final num? paidTotal;
  final num? unpaidTotal;
  final num? overdueTotal;
  final num? commissionTotal;
  final num? subscriptionTotal;
  final num? totalAmount;

  BillingSummaryModel({
    this.issuedTotal,
    this.paidTotal,
    this.unpaidTotal,
    this.overdueTotal,
    this.commissionTotal,
    this.subscriptionTotal,
    this.totalAmount,
  });

  factory BillingSummaryModel.fromJson(Map<String, dynamic> json) => BillingSummaryModel(
        issuedTotal: json['issued_total'],
        paidTotal: json['paid_total'],
        unpaidTotal: json['unpaid_total'],
        overdueTotal: json['overdue_total'],
        commissionTotal: json['commission_total'],
        subscriptionTotal: json['subscription_total'],
        totalAmount: json['total_amount'],
      );
}

class AdModel {
  final int? id;
  final String? title;
  final String? placement;
  final bool? isActive;
  final String? imageUrl;
  final String? createdAt;

  AdModel({
    this.id,
    this.title,
    this.placement,
    this.isActive,
    this.imageUrl,
    this.createdAt,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
        id: json['id'],
        title: json['title'],
        placement: json['placement'],
        isActive: json['is_active'],
        imageUrl: json['image_url'],
        createdAt: json['created_at'],
      );
}

class AdvertisementsSummaryModel {
  final ReportRangeModel? range;
  final int? totalAds;
  final int? activeAds;
  final int? inactiveAds;
  final int? expiredAds;
  final int? scheduledAds;
  final Map<String, int> adsByPlacement;
  final List<AdModel> latestAds;

  AdvertisementsSummaryModel({
    this.range,
    this.totalAds,
    this.activeAds,
    this.inactiveAds,
    this.expiredAds,
    this.scheduledAds,
    this.adsByPlacement = const {},
    this.latestAds = const [],
  });

  factory AdvertisementsSummaryModel.fromJson(Map<String, dynamic> json) => AdvertisementsSummaryModel(
        range: json['range'] != null ? ReportRangeModel.fromJson(json['range']) : null,
        totalAds: json['total_ads'],
        activeAds: json['active_ads'],
        inactiveAds: json['inactive_ads'],
        expiredAds: json['expired_ads'],
        scheduledAds: json['scheduled_ads'],
        adsByPlacement: json['ads_by_placement'] != null
            ? Map<String, int>.from(json['ads_by_placement'])
            : {},
        latestAds: json['latest_ads'] != null
            ? List.from(json['latest_ads']).map((e) => AdModel.fromJson(e)).toList()
            : [],
      );
}

// ---------------- Overview ----------------

class OverviewEntitiesModel {
  final int? totalUsers;
  final int? totalCustomers;
  final int? totalProviders;
  final Map<String, int> providersByType;
  final Map<String, Map<String, int>> providersByStatus;

  OverviewEntitiesModel({
    this.totalUsers,
    this.totalCustomers,
    this.totalProviders,
    this.providersByType = const {},
    this.providersByStatus = const {},
  });

  factory OverviewEntitiesModel.fromJson(Map<String, dynamic> json) => OverviewEntitiesModel(
        totalUsers: json['total_users'],
        totalCustomers: json['total_customers'],
        totalProviders: json['total_providers'],
        providersByType: json['providers_by_type'] != null
            ? Map<String, int>.from(json['providers_by_type'])
            : {},
        providersByStatus: json['providers_by_status'] != null
            ? (json['providers_by_status'] as Map<String, dynamic>)
                .map((key, value) => MapEntry(key, Map<String, int>.from(value)))
            : {},
      );
}

class OverviewReportModel {
  final ReportRangeModel? range;
  final OverviewEntitiesModel? entities;
  final Map<String, OperationCountModel> operationsSummary;
  final RevenueSummaryModel? revenueSummary;
  final BillingSummaryModel? billingSummary;
  final AdvertisementsSummaryModel? advertisementsSummary;

  OverviewReportModel({
    this.range,
    this.entities,
    this.operationsSummary = const {},
    this.revenueSummary,
    this.billingSummary,
    this.advertisementsSummary,
  });

  factory OverviewReportModel.fromJson(Map<String, dynamic> json) => OverviewReportModel(
        range: json['range'] != null ? ReportRangeModel.fromJson(json['range']) : null,
        entities: json['entities'] != null ? OverviewEntitiesModel.fromJson(json['entities']) : null,
        operationsSummary: json['operations_summary'] != null
            ? (json['operations_summary'] as Map<String, dynamic>)
                .map((key, value) => MapEntry(key, OperationCountModel.fromJson(value)))
            : {},
        revenueSummary:
            json['revenue_summary'] != null ? RevenueSummaryModel.fromJson(json['revenue_summary']) : null,
        billingSummary:
            json['billing_summary'] != null ? BillingSummaryModel.fromJson(json['billing_summary']) : null,
        advertisementsSummary: json['advertisements_summary'] != null
            ? AdvertisementsSummaryModel.fromJson(json['advertisements_summary'])
            : null,
      );
}

class OverviewReportResponseModel {
  final bool? success;
  final OverviewReportModel? data;

  OverviewReportResponseModel({this.success, this.data});

  factory OverviewReportResponseModel.fromJson(Map<String, dynamic> json) => OverviewReportResponseModel(
        success: json['success'],
        data: json['data'] != null ? OverviewReportModel.fromJson(json['data']) : null,
      );
}

// ---------------- Operations (مبني على افتراض - راجع الملاحظة بالأعلى) ----------------

class OperationsReportModel {
  final ReportRangeModel? range;
  final String? groupBy;
  final Map<String, OperationCountModel> operations;

  OperationsReportModel({this.range, this.groupBy, this.operations = const {}});

  factory OperationsReportModel.fromJson(Map<String, dynamic> json) {
    final rawMap = Map<String, dynamic>.from(json)
      ..remove('range')
      ..remove('group_by');
    return OperationsReportModel(
      range: json['range'] != null ? ReportRangeModel.fromJson(json['range']) : null,
      groupBy: json['group_by'],
      operations: rawMap.map(
        (key, value) => MapEntry(key, OperationCountModel.fromJson(Map<String, dynamic>.from(value))),
      ),
    );
  }
}

class OperationsReportResponseModel {
  final bool? success;
  final OperationsReportModel? data;

  OperationsReportResponseModel({this.success, this.data});

  factory OperationsReportResponseModel.fromJson(Map<String, dynamic> json) => OperationsReportResponseModel(
        success: json['success'],
        data: json['data'] != null ? OperationsReportModel.fromJson(json['data']) : null,
      );
}

// ---------------- Providers ----------------

class TopProviderModel {
  final int? providerId;
  final String? providerName;
  final int? completedCount;

  TopProviderModel({this.providerId, this.providerName, this.completedCount});

  factory TopProviderModel.fromJson(Map<String, dynamic> json) => TopProviderModel(
        providerId: json['provider_id'],
        providerName: json['provider_name'],
        completedCount: json['completed_count'],
      );
}

class NeedingActionModel {
  final int? pendingApproval;
  final int? overdueBillingCount;
  final int? notConfiguredBillingCount;

  NeedingActionModel({
    this.pendingApproval,
    this.overdueBillingCount,
    this.notConfiguredBillingCount,
  });

  factory NeedingActionModel.fromJson(Map<String, dynamic> json) => NeedingActionModel(
        pendingApproval: json['pending_approval'],
        overdueBillingCount: json['overdue_billing_count'],
        notConfiguredBillingCount: json['not_configured_billing_count'],
      );
}

class ProvidersReportModel {
  final Map<String, int> countsByType;
  final Map<String, Map<String, int>> countsByProviderStatus;
  final Map<String, int> countsByBillingStatus;
  final Map<String, List<TopProviderModel>> topProvidersByCompletedOperations;
  final NeedingActionModel? needingAction;

  ProvidersReportModel({
    this.countsByType = const {},
    this.countsByProviderStatus = const {},
    this.countsByBillingStatus = const {},
    this.topProvidersByCompletedOperations = const {},
    this.needingAction,
  });

  factory ProvidersReportModel.fromJson(Map<String, dynamic> json) => ProvidersReportModel(
        countsByType:
            json['counts_by_type'] != null ? Map<String, int>.from(json['counts_by_type']) : {},
        countsByProviderStatus: json['counts_by_provider_status'] != null
            ? (json['counts_by_provider_status'] as Map<String, dynamic>)
                .map((key, value) => MapEntry(key, Map<String, int>.from(value)))
            : {},
        countsByBillingStatus: json['counts_by_billing_status'] != null
            ? Map<String, int>.from(json['counts_by_billing_status'])
            : {},
        topProvidersByCompletedOperations: json['top_providers_by_completed_operations'] != null
            ? (json['top_providers_by_completed_operations'] as Map<String, dynamic>).map(
                (key, value) => MapEntry(
                  key,
                  List.from(value).map((e) => TopProviderModel.fromJson(e)).toList(),
                ),
              )
            : {},
        needingAction:
            json['needing_action'] != null ? NeedingActionModel.fromJson(json['needing_action']) : null,
      );
}

class ProvidersReportResponseModel {
  final bool? success;
  final ProvidersReportModel? data;

  ProvidersReportResponseModel({this.success, this.data});

  factory ProvidersReportResponseModel.fromJson(Map<String, dynamic> json) => ProvidersReportResponseModel(
        success: json['success'],
        data: json['data'] != null ? ProvidersReportModel.fromJson(json['data']) : null,
      );
}

// ---------------- Financial ----------------

class FinancialReportModel {
  final ReportRangeModel? range;
  final String? groupBy;
  final RevenueSummaryModel? grossRevenue;
  final BillingSummaryModel? billing;

  FinancialReportModel({this.range, this.groupBy, this.grossRevenue, this.billing});

  factory FinancialReportModel.fromJson(Map<String, dynamic> json) => FinancialReportModel(
        range: json['range'] != null ? ReportRangeModel.fromJson(json['range']) : null,
        groupBy: json['group_by'],
        grossRevenue:
            json['gross_revenue'] != null ? RevenueSummaryModel.fromJson(json['gross_revenue']) : null,
        billing: json['billing'] != null ? BillingSummaryModel.fromJson(json['billing']) : null,
      );
}

class FinancialReportResponseModel {
  final bool? success;
  final FinancialReportModel? data;

  FinancialReportResponseModel({this.success, this.data});

  factory FinancialReportResponseModel.fromJson(Map<String, dynamic> json) => FinancialReportResponseModel(
        success: json['success'],
        data: json['data'] != null ? FinancialReportModel.fromJson(json['data']) : null,
      );
}

// ---------------- Billing ----------------

class InvoiceModel {
  // latest_invoices إجت [] بالمثال - الحقول مبنية على تخمين منطقي، عدّلها عند توفر بيانات فعلية
  final int? id;
  final int? providerId;
  final String? providerName;
  final num? amount;
  final String? status;
  final String? issuedAt;
  final String? dueAt;
  final String? paidAt;

  InvoiceModel({
    this.id,
    this.providerId,
    this.providerName,
    this.amount,
    this.status,
    this.issuedAt,
    this.dueAt,
    this.paidAt,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        id: json['id'],
        providerId: json['provider_id'],
        providerName: json['provider_name'],
        amount: json['amount'],
        status: json['status'],
        issuedAt: json['issued_at'],
        dueAt: json['due_at'],
        paidAt: json['paid_at'],
      );
}

class BillingReportModel {
  final ReportRangeModel? range;
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
  final List<InvoiceModel> latestInvoices;

  BillingReportModel({
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

  factory BillingReportModel.fromJson(Map<String, dynamic> json) => BillingReportModel(
        range: json['range'] != null ? ReportRangeModel.fromJson(json['range']) : null,
        invoicesCount: json['invoices_count'],
        draftCount: json['draft_count'],
        issuedCount: json['issued_count'],
        overdueCount: json['overdue_count'],
        paidCount: json['paid_count'],
        cancelledCount: json['cancelled_count'],
        paidTotal: json['paid_total'],
        unpaidTotal: json['unpaid_total'],
        overdueTotal: json['overdue_total'],
        averageInvoiceAmount: json['average_invoice_amount'],
        providersWithOverdueCount: json['providers_with_overdue_count'],
        latestInvoices: json['latest_invoices'] != null
            ? List.from(json['latest_invoices']).map((e) => InvoiceModel.fromJson(e)).toList()
            : [],
      );
}

class BillingReportResponseModel {
  final bool? success;
  final BillingReportModel? data;

  BillingReportResponseModel({this.success, this.data});

  factory BillingReportResponseModel.fromJson(Map<String, dynamic> json) => BillingReportResponseModel(
        success: json['success'],
        data: json['data'] != null ? BillingReportModel.fromJson(json['data']) : null,
      );
}

// ---------------- Advertisements ----------------

class AdvertisementsReportResponseModel {
  final bool? success;
  final AdvertisementsSummaryModel? data;

  AdvertisementsReportResponseModel({this.success, this.data});

  factory AdvertisementsReportResponseModel.fromJson(Map<String, dynamic> json) =>
      AdvertisementsReportResponseModel(
        success: json['success'],
        data: json['data'] != null ? AdvertisementsSummaryModel.fromJson(json['data']) : null,
      );
}