// مصدر بيانات طلبات المتجر عبر API.
import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/spare_parts_store/customer/checkout/data/models/order_model.dart';

class OwnerOrdersRemoteDataSource {
  const OwnerOrdersRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<List<OrderModel>> getOrders() async {
    final response = await _apiService.get(endPoint: ApiEndpoints.ownerOrders);
    return OrderModel.listFromResponse(response);
  }

  Future<OrderModel> getOrderDetails(int orderId) async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.ownerOrderById(orderId),
    );
    return OrderModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<OrderModel> acceptOrder(int orderId) async {
    final response = await _apiService.post(
      endPoint: ApiEndpoints.ownerAcceptOrder(orderId),
    );
    return OrderModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<OrderModel> rejectOrder(int orderId, String reason) async {
    final response = await _apiService.post(
      endPoint: ApiEndpoints.ownerRejectOrder(orderId),
      data: {'reason': reason},
    );
    return OrderModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<OrderModel> updateStatus(
    int orderId,
    String status,
    String notes,
  ) async {
    final response = await _apiService.post(
      endPoint: ApiEndpoints.ownerUpdateOrderStatus(orderId),
      data: {'status': status, 'notes': notes},
    );
    return OrderModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
