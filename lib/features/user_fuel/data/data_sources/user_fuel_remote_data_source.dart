
import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/user_fuel/data/model/user_fuel_order_model.dart';
import 'package:car_care/features/user_fuel/data/model/user_fuel_track_model.dart';


class UserFuelRemoteDataSource {
  final ApiService _api;
  const UserFuelRemoteDataSource(this._api);

  Future<UserFuelOrderListModel> getAllOrders() async {
    final res = await _api.get(endPoint: '${ApiEndpoints.userFuel}');
    return UserFuelOrderListModel.fromJson(res);
  }

  Future<UserFuelOrderModel> getOrder(int id) async {
    final res = await _api.get(endPoint: '${ApiEndpoints.userFuel}/$id');
    return UserFuelOrderModel.fromJson(res);
  }

  Future<UserFuelOrderModel> addEmergencyOrder(
      Map<String, dynamic> data) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.userFuel}/emergency',
      data: data,
    );
    return UserFuelOrderModel.fromJson(res);
  }

  Future<void> cancelOrder(int id, String reason) async {
    await _api.post(
      endPoint: '${ApiEndpoints.userFuel}/cancel/$id',
      data: {'cancellation_reason': reason},
    );
  }

  Future<UserFuelTrackModel> trackOrder(int id) async {
    final res =
        await _api.get(endPoint: '${ApiEndpoints.userFuel}/$id/track');
    return UserFuelTrackModel.fromJson(res);
  }
}