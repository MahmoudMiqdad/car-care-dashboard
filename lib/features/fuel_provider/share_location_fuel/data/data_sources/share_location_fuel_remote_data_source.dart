import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';

class ShareFuelProviderLocationRemoteDataSource {
  final ApiService _api;
  const ShareFuelProviderLocationRemoteDataSource(this._api);

  Future<void> shareLocation({
    required int orderId,
    required double lat,
    required double lng,
  }) async {
    await _api.post(
      endPoint: '${ApiEndpoints.fuelProvider}/orders/$orderId/location',
      data: {
        'latitude': lat,
        'longitude': lng,
      },
    );
  }
}