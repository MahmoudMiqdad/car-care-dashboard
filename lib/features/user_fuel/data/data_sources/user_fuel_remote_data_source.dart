import 'package:car_care/core/network/api_service.dart';

class UserFuelRemoteDataSource {

  const UserFuelRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<Map<String, dynamic>> userFuel(Map<String, dynamic> data) async => _apiService.post(endPoint: 'user_fuel/user_fuel', data: data);

}
