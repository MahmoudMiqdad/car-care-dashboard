import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/sos/data/models/sos_model.dart';
import 'package:car_care/features/sos/data/models/tracking_techniciain_model.dart';


class SosRemoteDataSource {
  final ApiService _apiService;

  SosRemoteDataSource(this._apiService);

  Future<SosModel> createSos(Map<String, dynamic> data) async {
    final response = await _apiService.post(
      endPoint: "/sos",
      data: data,
    );
    return SosModel.fromJson(response);
  }

  Future<List<SosData>> getAllSos() async {
    final response = await _apiService.get(
      endPoint: "/api/sos",
    );

    return List.from(response['data'])
        .map((e) => SosData.fromJson(e))
        .toList();
  }

  Future<SosData> getSos(int id) async {
    final response = await _apiService.get(
      endPoint: "/api/sos/$id",
    );

    return SosData.fromJson(response['data']);
  }

  Future<void> cancelSos(int id, String reason) async {
    await _apiService.post(
      endPoint: "/api/sos/$id/cancel",
      data: {
        "cancellation_reason": reason,
      },
    );
  }
  Future<TrackingData> trackSos(int id) async {
  final res = await _apiService.get(
    endPoint: "/api/sos/$id/track",
  );

  return TrackingData.fromJson(res['data']);
}
}