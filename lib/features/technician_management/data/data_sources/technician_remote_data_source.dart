import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/technician_management/data/models/technician_model.dart';



class TechnicianRemoteDataSource {
  final ApiService _api;
  const TechnicianRemoteDataSource(this._api);


  Future<TechnicianListModel> getTechnicians({required String status}) async {
    final res = await _api.get(
      endPoint: '${ApiEndpoints.adminTechnicianApprovals}?status=$status',
    );
    return TechnicianListModel.fromJson(res);
  }

  Future<TechnicianModel> getTechnician(int id) async {
    final res = await _api.get(
      endPoint: '${ApiEndpoints.adminTechnicianApprovals}/$id',
    );
    return TechnicianModel.fromJson(res);
  }

  Future<TechnicianModel> approveTechnician(int id) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminTechnicianApprovals}/$id/approve',
      data: {},
    );
    return TechnicianModel.fromJson(res);
  }

  Future<TechnicianModel> rejectTechnician(int id, String reason) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminTechnicianApprovals}/$id/reject',
      data: {'rejection_reason': reason},
    );
    return TechnicianModel.fromJson(res);
  }

  Future<TechnicianModel> suspendTechnician(int id) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminTechnicianApprovals}/$id/suspend',
      data: {},
    );
    return TechnicianModel.fromJson(res);
  }

  Future<TechnicianModel> reactivateTechnician(int id) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminTechnicianApprovals}/$id/reactivate',
      data: {},
    );
    return TechnicianModel.fromJson(res);
  }
}
