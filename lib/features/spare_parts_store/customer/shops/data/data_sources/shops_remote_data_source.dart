import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/spare_parts_store/customer/products/data/models/product_model.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/data/models/shop_model.dart';

class ShopsRemoteDataSource {
  const ShopsRemoteDataSource(this._apiService);
  final ApiService _apiService;

  Future<List<ShopModel>> getShops({String? city}) async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.customerShops,
      queryParameters: {
        if (city != null && city.trim().isNotEmpty) 'city': city.trim(),
      },
    );

    return ShopModel.listFromResponse(response);
  }

  Future<ShopModel> getShopDetails(int shopId) async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.customerShopById(shopId),
    );
    return ShopModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<List<ProductModel>> getShopProducts(int shopId) async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.customerShopProducts(shopId),
    );
    return ProductModel.listFromResponse(response);
  }
}
