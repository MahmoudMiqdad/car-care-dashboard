// advertisement_remote_data_source.dart
import 'package:car_care/features/advertisement/data/models/advertisement_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';


Future<MultipartFile?> _toMultipart(XFile? image) async {
  if (image == null) return null;
  final bytes = await image.readAsBytes();
  return MultipartFile.fromBytes(bytes, filename: image.name);
}

class AdvertisementRemoteDataSource {
  final ApiService _api;
  const AdvertisementRemoteDataSource(this._api);

  Future<AdvertisementListModel> getAdvertisements({
    bool? isActive,
    String? placement,
    int? perPage,
  }) async {
    final query = <String, dynamic>{
      if (isActive != null) 'is_active': isActive,
      if (placement != null && placement != 'all') 'placement': placement,
      if (perPage != null) 'per_page': perPage,
    };
    final queryString = Uri(queryParameters: query.map((k, v) => MapEntry(k, v.toString()))).query;
    final res = await _api.get(
      endPoint: queryString.isEmpty
          ? ApiEndpoints.adminAdvertisements
          : '${ApiEndpoints.adminAdvertisements}?$queryString',
    );
    return AdvertisementListModel.fromJson(res);
  }

  Future<AdvertisementModel> getAdvertisement(int id) async {
    final res = await _api.get(endPoint: '${ApiEndpoints.adminAdvertisements}/$id');
    return AdvertisementModel.fromJson(res);
  }

  Future<AdvertisementModel> createAdvertisement({
    required String title,
    required String placement,
    String? linkUrl,
    String? startsAt,
    String? endsAt,
    int? sortOrder,
    required XFile image,
  }) async {
    final multipartImage = await _toMultipart(image);
    final formData = FormData.fromMap({
      'title': title,
      'placement': placement,
      if (linkUrl != null && linkUrl.isNotEmpty) 'link_url': linkUrl,
      if (startsAt != null) 'starts_at': startsAt,
      if (endsAt != null) 'ends_at': endsAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      'image': multipartImage,
    });
    final res = await _api.postMultipart(
      endPoint: ApiEndpoints.adminAdvertisements,
      formData: formData,
    );
    return AdvertisementModel.fromJson(res);
  }

  Future<AdvertisementModel> updateAdvertisement({
    required int id,
    String? title,
    String? placement,
    bool? isActive,
    int? sortOrder,
    XFile? image,
  }) async {
    final multipartImage = await _toMultipart(image);
    final formData = FormData.fromMap({
      if (title != null) 'title': title,
      if (placement != null) 'placement': placement,
      if (isActive != null) 'is_active': isActive,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (multipartImage != null) 'image': multipartImage,
      '_method': 'PUT',
    });
    final res = await _api.postMultipart(
      endPoint: '${ApiEndpoints.adminAdvertisements}/$id',
      formData: formData,
    );
    return AdvertisementModel.fromJson(res);
  }

  Future<AdvertisementModel> activateAdvertisement(int id) async {
    final res = await _api.post(endPoint: '${ApiEndpoints.adminAdvertisements}/$id/activate', data: {});
    return AdvertisementModel.fromJson(res);
  }

  Future<AdvertisementModel> deactivateAdvertisement(int id) async {
    final res = await _api.post(endPoint: '${ApiEndpoints.adminAdvertisements}/$id/deactivate', data: {});
    return AdvertisementModel.fromJson(res);
  }

  Future<void> deleteAdvertisement(int id) async {
    await _api.delete(endPoint: '${ApiEndpoints.adminAdvertisements}/$id');
  }
}