import 'package:car_care/core/network/api_service.dart';

class TechnicianSosRemoteDataSource {

  const TechnicianSosRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<Map<String, dynamic>> technicianSos(Map<String, dynamic> data) async => _apiService.post(endPoint: 'technician_sos/technician_sos', data: data);

}
