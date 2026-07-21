import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
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

  Future<List<OrderModel>> getOrders({String? status}) async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.customerOrders,
      queryParameters: {
        if (status != null && status.isNotEmpty) 'status': status,
      },
    );
    return OrderModel.listFromResponse(response);
  }

  Future<String> cancelOrder(int orderId, String reason) async {
    final response = await _apiService.post(
      endPoint: ApiEndpoints.customerCancelOrder(orderId),
      data: {'cancellation_reason': reason},
    );
    if (response['success'] == false) {
      throw ServerExpcptions(
        error: Failure(
          message: (response['message'] ?? 'حدث خطأ أثناء الإلغاء').toString(),
        ),
      );
    }
    return (response['message'] ?? 'تم إلغاء الطلب بنجاح').toString();
  }
}
