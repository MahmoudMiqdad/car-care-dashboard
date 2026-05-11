import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/technician/technician_location/data/models/technician_location_model.dart';

class TechnicianLocationRemoteDataSource {
  final ApiService _api;

  TechnicianLocationRemoteDataSource(this._api);

  // تحديث موقع الفني العام
  Future<void> updateLocation({
    required double lat,
    required double lng,
  }) async {
    await _api.post(
      endPoint: "/technician/location",
      data: {
        "latitude": lat,
        "longitude": lng,
      },
    );
  }

  // إرسال موقع الفني داخل طلب SOS
  Future<TechnicianLocationData> shareLocation({
    required int sosId,
    required double lat,
    required double lng,
  }) async {
    final res = await _api.post(
      endPoint: "/api/sos/$sosId/location",
      data: {
        "lat": lat,
        "lng": lng,
      },
    );

    return TechnicianLocationData.fromJson(res['data']);
  }
}