import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/dashboard/data/models/dashboard_model.dart';

class DashboardRemoteDataSource {
  final ApiService _api;
  const DashboardRemoteDataSource(this._api);

  Future<HealthCheckModel> healthCheck() async {
    final res = await _api.get(endPoint: ApiEndpoints.healthCheck);
    return HealthCheckModel.fromJson(res);
  }

  Future<AdvertisementListModel> getActiveAdvertisements() async {
    final res = await _api.get(endPoint: ApiEndpoints.activeAdvertisements);
    return AdvertisementListModel.fromJson(res);
  }

  Future<DashboardSummaryModel> getDashboardSummary() async {
    final res = await _api.get(endPoint: ApiEndpoints.dashboardSummary);
    return DashboardSummaryModel.fromJson(res);
  }

  Future<DashboardOperationsModel> getDashboardOperations({
    String? period,
    String? groupBy,
    String? from,
    String? to,
  }) async {
    final query = <String, String>{};
    if (period != null) query['period'] = period;
    if (groupBy != null) query['group_by'] = groupBy;
    if (from != null) query['from'] = from;
    if (to != null) query['to'] = to;

    final queryString = query.isEmpty
        ? ''
        : '?${query.entries.map((e) => '${e.key}=${e.value}').join('&')}';

    final res = await _api.get(endPoint: '${ApiEndpoints.dashboardOperations}$queryString');
    return DashboardOperationsModel.fromJson(res);
  }

  Future<DashboardRevenueModel> getDashboardRevenue({String? from, String? to}) async {
    final query = <String, String>{};
    if (from != null) query['from'] = from;
    if (to != null) query['to'] = to;

    final queryString = query.isEmpty
        ? ''
        : '?${query.entries.map((e) => '${e.key}=${e.value}').join('&')}';

    final res = await _api.get(endPoint: '${ApiEndpoints.dashboardRevenue}$queryString');
    return DashboardRevenueModel.fromJson(res);
  }
}