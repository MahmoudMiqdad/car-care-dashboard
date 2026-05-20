import 'package:car_care/core/network/api_service.dart';

class UserFuelOrdersRemoteDataSource {

  const UserFuelOrdersRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<Map<String, dynamic>> userFuelOrders(Map<String, dynamic> data) async => _apiService.post(endPoint: 'user_fuel_orders/user_fuel_orders', data: data);

}
