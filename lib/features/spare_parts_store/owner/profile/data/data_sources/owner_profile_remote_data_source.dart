// مصدر بيانات ملف متجر المالك عبر API.
import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/data/models/shop_model.dart';

class OwnerProfileRemoteDataSource {
  const OwnerProfileRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<ShopModel> getProfile() async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.ownerShopProfile,
    );
    return ShopModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<ShopModel> saveProfile({
    required String name,
    required String phone,
    required String city,
    required List<int> businessTypeIds,
    required List<int> carBrandIds,
    required List<int> partCategoryIds,
  }) async {
    final response = await _apiService.post(
      endPoint: ApiEndpoints.ownerShopProfile,
      data: {
        'name': name,
        'phone': phone,
        'city': city,
        'business_types': businessTypeIds,
        'car_brands': carBrandIds,
        'part_categories': partCategoryIds,
      },
    );
    return ShopModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
