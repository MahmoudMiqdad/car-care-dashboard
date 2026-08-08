import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/billing/data/models/billing_setting_model.dart';
import 'package:car_care/features/billing/presentation/constsnts/billing_setting_params.dart';

class BillingSettingRemoteDataSource {
  final ApiService _api;
  const BillingSettingRemoteDataSource(this._api);

  Future<BillingSettingListModel> getBillingSettings({
    String? providerType,
    int? providerId,
    String? billingType,
    bool? isActive,
  }) async {
    final query = <String, String>{};
    if (providerType != null && providerType.isNotEmpty) {
      query['provider_type'] = providerType;
    }
    if (providerId != null) query['provider_id'] = providerId.toString();
    if (billingType != null && billingType.isNotEmpty) {
      query['billing_type'] = billingType;
    }
    if (isActive != null) query['is_active'] = isActive.toString();

    final queryString = query.entries.map((e) => '${e.key}=${e.value}').join('&');
    final endPoint = queryString.isEmpty
        ? ApiEndpoints.adminBillingSettings
        : '${ApiEndpoints.adminBillingSettings}?$queryString';

    final res = await _api.get(endPoint: endPoint);
    return BillingSettingListModel.fromJson(res);
  }

  Future<BillingSettingModel> getBillingSetting(int id) async {
    final res =
        await _api.get(endPoint: '${ApiEndpoints.adminBillingSettings}/$id');
    return BillingSettingModel.fromJson(res);
  }

  Future<BillingSettingModel> createBillingSetting(
      BillingSettingParams params) async {
    final res = await _api.post(
      endPoint: ApiEndpoints.adminBillingSettings,
      data: params.toJson(),
    );
    return BillingSettingModel.fromJson(res);
  }

  Future<BillingSettingModel> updateBillingSetting(
      int id, BillingSettingParams params) async {
    // بستخدم put هون - إذا ApiService عندك ما فيها put، بدّلها لـ:
    // final res = await _api.post(endPoint: '${ApiEndpoints.adminBillingSettings}/$id', data: params.toJson());
    final res = await _api.put(
      endPoint: '${ApiEndpoints.adminBillingSettings}/$id',
      data: params.toJson(),
    );
    return BillingSettingModel.fromJson(res);
  }

  Future<Map<String, dynamic>> deleteBillingSetting(int id) async {
    // بستخدم delete هون - إذا ApiService عندك ما فيها delete، بدّلها لطريقتك بالمشروع
    final res =
        await _api.delete(endPoint: '${ApiEndpoints.adminBillingSettings}/$id');
    return res;
  }
}
