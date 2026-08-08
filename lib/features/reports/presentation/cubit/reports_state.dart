// lib/features/reports/presentation/cubit/reports_state.dart

import 'package:car_care/features/reports/domain/entities/reports_entity.dart';

class ReportsState {
  final OverviewReportEntity? overview;
  final bool overviewLoading;
  final String? overviewError;

  final OperationsReportEntity? operations;
  final bool operationsLoading;
  final String? operationsError;

  final ProvidersReportEntity? providers;
  final bool providersLoading;
  final String? providersError;

  final FinancialReportEntity? financial;
  final bool financialLoading;
  final String? financialError;

  final BillingReportEntity? billing;
  final bool billingLoading;
  final String? billingError;

  final AdvertisementsSummaryEntity? advertisements;
  final bool advertisementsLoading;
  final String? advertisementsError;

  const ReportsState({
    this.overview,
    this.overviewLoading = false,
    this.overviewError,
    this.operations,
    this.operationsLoading = false,
    this.operationsError,
    this.providers,
    this.providersLoading = false,
    this.providersError,
    this.financial,
    this.financialLoading = false,
    this.financialError,
    this.billing,
    this.billingLoading = false,
    this.billingError,
    this.advertisements,
    this.advertisementsLoading = false,
    this.advertisementsError,
  });
}