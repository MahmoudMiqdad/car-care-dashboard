import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/spare_parts_store/customer/checkout/data/models/order_model.dart';

class CustomerOrdersRemoteDataSource {
  const CustomerOrdersRemoteDataSource(this._apiService);
  final ApiService _apiService;

  Future<OrderModel> getOrderDetails(int orderId) async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.customerOrderById(orderId),
    );
    return OrderModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
