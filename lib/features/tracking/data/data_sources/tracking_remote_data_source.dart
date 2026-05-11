import 'package:car_care/core/network/api_service.dart';

class TrackingRemoteDataSource {

  const TrackingRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<Map<String, dynamic>> tracking(Map<String, dynamic> data) async => _apiService.post(endPoint: 'tracking/tracking', data: data);

}
