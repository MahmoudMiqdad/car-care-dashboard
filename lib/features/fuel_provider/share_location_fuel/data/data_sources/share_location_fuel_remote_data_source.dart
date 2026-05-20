import 'package:car_care/core/network/api_service.dart';

class ShareLocationFuelRemoteDataSource {

  const ShareLocationFuelRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<Map<String, dynamic>> shareLocationFuel(Map<String, dynamic> data) async => _apiService.post(endPoint: 'share_location_fuel/share_location_fuel', data: data);

}
