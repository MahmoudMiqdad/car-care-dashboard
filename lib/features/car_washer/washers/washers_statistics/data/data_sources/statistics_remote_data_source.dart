import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import '../models/statistics_model.dart';

class CarWasherStatisticsRemoteDataSource {
  const CarWasherStatisticsRemoteDataSource(this._apiService);
  final ApiService _apiService;

  Future<StatisticsModel> getStatistics() async {
    final res = await _apiService.get(
      endPoint: ApiEndpoints.washerStatistics,
    );
    final data = res['data'] as Map<String, dynamic>;
    return StatisticsModel.fromJson(data);
  }
}