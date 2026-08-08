import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/shop_management/data/models/shop_model.dart';

class ShopRemoteDataSource {
  final ApiService _api;
  const ShopRemoteDataSource(this._api);

  Future<ShopListModel> getShops({required String status}) async {
    final res = await _api.get(endPoint: '${ApiEndpoints.adminShopApprovals}?status=$status');
    return ShopListModel.fromJson(res);
  }

  Future<ShopModel> getShop(int id) async {
    final res = await _api.get(endPoint: '${ApiEndpoints.adminShopApprovals}/$id');
    return ShopModel.fromJson(res);
  }

  Future<ShopModel> approveShop(int id) async {
    final res = await _api.post(endPoint: '${ApiEndpoints.adminShopApprovals}/$id/approve', data: {});
    return ShopModel.fromJson(res);
  }

  Future<ShopModel> rejectShop(int id, String reason) async {
    final res = await _api.post(
      endPoint: '${ApiEndpoints.adminShopApprovals}/$id/reject',
      data: {'rejection_reason': reason},
    );
    return ShopModel.fromJson(res);
  }

  Future<ShopModel> suspendShop(int id) async {
    final res = await _api.post(endPoint: '${ApiEndpoints.adminShopApprovals}/$id/suspend', data: {});
    return ShopModel.fromJson(res);
  }

  Future<ShopModel> reactivateShop(int id) async {
    final res = await _api.post(endPoint: '${ApiEndpoints.adminShopApprovals}/$id/reactivate', data: {});
    return ShopModel.fromJson(res);
  }
}