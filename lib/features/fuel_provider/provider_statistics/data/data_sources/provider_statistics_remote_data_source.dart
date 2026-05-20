import 'package:car_care/core/network/api_service.dart';

class ProviderStatisticsRemoteDataSource {

  const ProviderStatisticsRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<Map<String, dynamic>> providerStatistics(Map<String, dynamic> data) async => _apiService.post(endPoint: 'provider_statistics/provider_statistics', data: data);

}
