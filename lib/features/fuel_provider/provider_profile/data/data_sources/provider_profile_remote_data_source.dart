import 'package:car_care/core/network/api_service.dart';

class ProviderProfileRemoteDataSource {

  const ProviderProfileRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<Map<String, dynamic>> providerProfile(Map<String, dynamic> data) async => _apiService.post(endPoint: 'provider_profile/provider_profile', data: data);

}
