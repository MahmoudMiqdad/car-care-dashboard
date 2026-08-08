import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/fuel_provider_management/data/models/fuel_provider_model.dart';

class FuelProviderRemoteDataSource {
  final ApiService _api;
  const FuelProviderRemoteDataSource(this._api);

  Future<FuelProviderListModel> getFuelProviders({required String status}) async {
    final res = await _api.get(
      endPoint: '${ApiEndpoints.adminFuelProviderApprovals}?status=$status',
    );
    return FuelProviderListModel.fromJson(res);
  }

  Future<FuelProviderModel> getFuelProvider(int id) async {
    final res = await _api.get(endPoint: '${ApiEndpoints.adminFuelProviderApprovals}/$id');
    return FuelProviderModel.fromJson(res);
  }

  Future<FuelProviderModel> approveFuelProvider(int id) async {
    final res =
        await _api.post(endPoint: '${ApiEndpoints.adminFuelProviderApprovals}/$id/approve', data: {});
    return FuelProviderModel.fromJson(res);
  }

  Future<FuelProviderModel> rejectFuelProvider(int id, String reason) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminFuelProviderApprovals}/$id/reject',
      data: {'rejection_reason': reason},
    );
    return FuelProviderModel.fromJson(res);
  }

  Future<FuelProviderModel> suspendFuelProvider(int id) async {
    final res =
        await _api.post(endPoint: '${ApiEndpoints.adminFuelProviderApprovals}/$id/suspend', data: {});
    return FuelProviderModel.fromJson(res);
  }

  Future<FuelProviderModel> reactivateFuelProvider(int id) async {
    final res =
        await _api.post(endPoint: '${ApiEndpoints.adminFuelProviderApprovals}/$id/reactivate', data: {});
    return FuelProviderModel.fromJson(res);
  }
}