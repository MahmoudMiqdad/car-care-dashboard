import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:dio/dio.dart';

import '../models/washer_profile_model.dart';

class ProfileWasherRemoteDataSource {
  const ProfileWasherRemoteDataSource(this._apiService);
  final ApiService _apiService;

  Future<WasherProfileModel> getMyProfile() async {
    final res = await _apiService.get(endPoint: ApiEndpoints.washerMyProfile);
    final data = res['data'] as Map<String, dynamic>;
    return WasherProfileModel.fromJson(data);
  }

  Future<WasherProfileModel> addOrUpdateProfile({
    required String shopName,
    required String phone,
    required String city,
    required String address,
    required String description,
    required List<String> services,
    required Map<String, int> servicePrices,
    required Map<String, String> workingHours,
  }) async {
    final res = await _apiService.post(
      endPoint: ApiEndpoints.washerAddOrUpdateProfile,
      data: {
        'shop_name': shopName,
        'phone': phone,
        'city': city,
        'address': address,
        'description': description,
        'services': services,
        'service_prices': servicePrices,
        'working_hours': workingHours,
      },
    );
    final data = res['data'] as Map<String, dynamic>;
    return WasherProfileModel.fromJson(data);
  }

  Future<String> uploadLogo(String filePath) async {
    final form = FormData.fromMap({
      'logo': await MultipartFile.fromFile(filePath),
    });

    final res = await _apiService.post(
      endPoint: ApiEndpoints.washerProfileLogo,
      data: form,
    );

    final data = (res['data'] as Map<String, dynamic>);
    return (data['logo_url'] ?? '').toString();
  }

  Future<void> deleteLogo() async {
    await _apiService.delete(endPoint: ApiEndpoints.washerProfileLogo);
  }
}
