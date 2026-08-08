// lib/features/reports/presentation/cubit/reports_cubit.dart
import 'package:car_care/features/reports/domain/repositories/i_reports_repository.dart';
import 'package:car_care/features/reports/presentation/cubit/reports_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportsCubit extends Cubit<ReportsState> {
  final IReportsRepository _repo;
  ReportsCubit(this._repo) : super(const ReportsState());

  Future<void> loadOverview({String? from, String? to, String? providerType, String? status}) async {
    emit(ReportsState(
      overviewLoading: true,
      operations: state.operations,
      operationsLoading: state.operationsLoading,
      operationsError: state.operationsError,
      providers: state.providers,
      providersLoading: state.providersLoading,
      providersError: state.providersError,
      financial: state.financial,
      financialLoading: state.financialLoading,
      financialError: state.financialError,
      billing: state.billing,
      billingLoading: state.billingLoading,
      billingError: state.billingError,
      advertisements: state.advertisements,
      advertisementsLoading: state.advertisementsLoading,
      advertisementsError: state.advertisementsError,
    ));
    final res = await _repo.getOverviewReport(from: from, to: to, providerType: providerType, status: status);
    res.fold(
      (l) => emit(_copy(overviewLoading: false, overviewError: l.message)),
      (r) => emit(_copy(overviewLoading: false, overview: r)),
    );
  }

  Future<void> loadOperations({
    String? from,
    String? to,
    String? operationType,
    String? status,
    String? groupBy,
  }) async {
    emit(_copy(operationsLoading: true, operationsError: null));
    final res = await _repo.getOperationsReport(
      from: from,
      to: to,
      operationType: operationType,
      status: status,
      groupBy: groupBy,
    );
    res.fold(
      (l) => emit(_copy(operationsLoading: false, operationsError: l.message)),
      (r) => emit(_copy(operationsLoading: false, operations: r)),
    );
  }

  Future<void> loadProviders({String? providerType, String? providerStatus, String? billingStatus}) async {
    emit(_copy(providersLoading: true, providersError: null));
    final res = await _repo.getProvidersReport(
      providerType: providerType,
      providerStatus: providerStatus,
      billingStatus: billingStatus,
    );
    res.fold(
      (l) => emit(_copy(providersLoading: false, providersError: l.message)),
      (r) => emit(_copy(providersLoading: false, providers: r)),
    );
  }

  Future<void> loadFinancial({String? from, String? to, String? providerType, String? groupBy}) async {
    emit(_copy(financialLoading: true, financialError: null));
    final res = await _repo.getFinancialReport(from: from, to: to, providerType: providerType, groupBy: groupBy);
    res.fold(
      (l) => emit(_copy(financialLoading: false, financialError: l.message)),
      (r) => emit(_copy(financialLoading: false, financial: r)),
    );
  }

  Future<void> loadBilling({String? from, String? to, String? providerType, String? status}) async {
    emit(_copy(billingLoading: true, billingError: null));
    final res = await _repo.getBillingReport(from: from, to: to, providerType: providerType, status: status);
    res.fold(
      (l) => emit(_copy(billingLoading: false, billingError: l.message)),
      (r) => emit(_copy(billingLoading: false, billing: r)),
    );
  }

  Future<void> loadAdvertisements({String? from, String? to, String? placement, bool? isActive}) async {
    emit(_copy(advertisementsLoading: true, advertisementsError: null));
    final res =
        await _repo.getAdvertisementsReport(from: from, to: to, placement: placement, isActive: isActive);
    res.fold(
      (l) => emit(_copy(advertisementsLoading: false, advertisementsError: l.message)),
      (r) => emit(_copy(advertisementsLoading: false, advertisements: r)),
    );
  }

  ReportsState _copy({
    var overview,
    bool? overviewLoading,
    var overviewError,
    var operations,
    bool? operationsLoading,
    var operationsError,
    var providers,
    bool? providersLoading,
    var providersError,
    var financial,
    bool? financialLoading,
    var financialError,
    var billing,
    bool? billingLoading,
    var billingError,
    var advertisements,
    bool? advertisementsLoading,
    var advertisementsError,
  }) {
    return ReportsState(
      overview: overview ?? state.overview,
      overviewLoading: overviewLoading ?? state.overviewLoading,
      overviewError: overviewError,
      operations: operations ?? state.operations,
      operationsLoading: operationsLoading ?? state.operationsLoading,
      operationsError: operationsError,
      providers: providers ?? state.providers,
      providersLoading: providersLoading ?? state.providersLoading,
      providersError: providersError,
      financial: financial ?? state.financial,
      financialLoading: financialLoading ?? state.financialLoading,
      financialError: financialError,
      billing: billing ?? state.billing,
      billingLoading: billingLoading ?? state.billingLoading,
      billingError: billingError,
      advertisements: advertisements ?? state.advertisements,
      advertisementsLoading: advertisementsLoading ?? state.advertisementsLoading,
      advertisementsError: advertisementsError,
    );
  }
}