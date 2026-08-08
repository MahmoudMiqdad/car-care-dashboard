import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/carwasher_management/data/models/carwasher_model.dart';

class CarwasherRemoteDataSource {
  final ApiService _api;
  const CarwasherRemoteDataSource(this._api);

  Future<CarwasherListModel> getCarwashers({required String status}) async {
    final res = await _api.get(
      endPoint: '${ApiEndpoints.adminCarWasherApprovals}?status=$status',
    );
    return CarwasherListModel.fromJson(res);
  }

  Future<CarwasherModel> getCarwasher(int id) async {
    final res = await _api.get(
      endPoint: '${ApiEndpoints.adminCarWasherApprovals}/$id',
    );
    return CarwasherModel.fromJson(res);
  }

  Future<CarwasherModel> approveCarwasher(int id) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminCarWasherApprovals}/$id/approve',
      data: {},
    );
    return CarwasherModel.fromJson(res);
  }

  Future<CarwasherModel> rejectCarwasher(int id, String reason) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminCarWasherApprovals}/$id/reject',
      data: {'rejection_reason': reason},
    );
    return CarwasherModel.fromJson(res);
  }

  Future<CarwasherModel> suspendCarwasher(int id) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminCarWasherApprovals}/$id/suspend',
      data: {},
    );
    return CarwasherModel.fromJson(res);
  }

  Future<CarwasherModel> reactivateCarwasher(int id) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminCarWasherApprovals}/$id/reactivate',
      data: {},
    );
    return CarwasherModel.fromJson(res);
  }
}