// lib/features/reports/data/data_sources/reports_remote_data_source.dart
import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/reports/data/models/reports_models.dart';

class ReportsRemoteDataSource {
  final ApiService _api;
  const ReportsRemoteDataSource(this._api);

  // عدّل هاي الدالة إذا ApiService.get عندك بياخد queryParameters كـ Map مباشرة
  // بدل ما نبني الكويري سترينغ يدوي
  String _buildQuery(Map<String, dynamic> params) {
    final clean = Map<String, dynamic>.from(params)
      ..removeWhere((key, value) => value == null);
    if (clean.isEmpty) return '';
    final query = clean.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}').join('&');
    return '?$query';
  }

  Future<OverviewReportResponseModel> getOverview({
    String? from,
    String? to,
    String? providerType,
    String? status,
  }) async {
    final query = _buildQuery({
      'from': from,
      'to': to,
      'provider_type': providerType,
      'status': status,
    });
    final res = await _api.get(endPoint: '${ApiEndpoints.reportsOverview}$query');
    return OverviewReportResponseModel.fromJson(res);
  }

  Future<OperationsReportResponseModel> getOperations({
    String? from,
    String? to,
    String? operationType,
    String? status,
    String? groupBy,
  }) async {
    final query = _buildQuery({
      'from': from,
      'to': to,
      'operation_type': operationType,
      'status': status,
      'group_by': groupBy,
    });
    final res = await _api.get(endPoint: '${ApiEndpoints.reportsOperations}$query');
    return OperationsReportResponseModel.fromJson(res);
  }

  Future<ProvidersReportResponseModel> getProviders({
    String? providerType,
    String? providerStatus,
    String? billingStatus,
  }) async {
    final query = _buildQuery({
      'provider_type': providerType,
      'provider_status': providerStatus,
      'billing_status': billingStatus,
    });
    final res = await _api.get(endPoint: '${ApiEndpoints.reportsProviders}$query');
    return ProvidersReportResponseModel.fromJson(res);
  }

  Future<FinancialReportResponseModel> getFinancial({
    String? from,
    String? to,
    String? providerType,
    String? groupBy,
  }) async {
    final query = _buildQuery({
      'from': from,
      'to': to,
      'provider_type': providerType,
      'group_by': groupBy,
    });
    final res = await _api.get(endPoint: '${ApiEndpoints.reportsFinancial}$query');
    return FinancialReportResponseModel.fromJson(res);
  }

  Future<BillingReportResponseModel> getBilling({
    String? from,
    String? to,
    String? providerType,
    String? status,
  }) async {
    final query = _buildQuery({
      'from': from,
      'to': to,
      'provider_type': providerType,
      'status': status,
    });
    final res = await _api.get(endPoint: '${ApiEndpoints.reportsBilling}$query');
    return BillingReportResponseModel.fromJson(res);
  }

 Future<AdvertisementsReportResponseModel> getAdvertisements({
  String? from,
  String? to,
  String? placement,
  bool? isActive,
}) async {
  final query = _buildQuery({
    'from': from,
    'to': to,
    'placement': placement,
    'is_active': isActive == null ? null : (isActive ? 1 : 0), 
  });
  final res = await _api.get(endPoint: '${ApiEndpoints.reportsAdvertisements}$query');
  return AdvertisementsReportResponseModel.fromJson(res);
}
}