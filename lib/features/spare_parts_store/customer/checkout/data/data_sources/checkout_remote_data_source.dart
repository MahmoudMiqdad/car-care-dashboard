import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/spare_parts_store/customer/checkout/data/models/order_model.dart';

class CheckoutRemoteDataSource {
  const CheckoutRemoteDataSource(this._apiService);
  final ApiService _apiService;

  Future<OrderModel> createOrder({
    required double latitude,
    required double longitude,
    required String addressNote,
  }) async {
    //إرسال الطلب ل api 
    //مع البارميترات الثلاثة
    final response = await _apiService.post(
      endPoint: ApiEndpoints.customerOrders,
      data: {
        'latitude': latitude,
        'longitude': longitude,
        'address_note': addressNote,
      },
    );
    return OrderModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
