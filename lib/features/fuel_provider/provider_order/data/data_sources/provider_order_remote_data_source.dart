import 'package:car_care/core/network/api_service.dart';

class ProviderOrderRemoteDataSource {

  const ProviderOrderRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<Map<String, dynamic>> providerOrder(Map<String, dynamic> data) async => _apiService.post(endPoint: 'provider_order/provider_order', data: data);

}
