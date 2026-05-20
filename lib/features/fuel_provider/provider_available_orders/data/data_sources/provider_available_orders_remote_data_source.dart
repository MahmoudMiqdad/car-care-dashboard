import 'package:car_care/core/network/api_service.dart';

class ProviderAvailableOrdersRemoteDataSource {

  const ProviderAvailableOrdersRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<Map<String, dynamic>> providerAvailableOrders(Map<String, dynamic> data) async => _apiService.post(endPoint: 'provider_available_orders/provider_available_orders', data: data);

}
