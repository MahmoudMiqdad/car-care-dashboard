import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/spare_parts_store/customer/cart/data/models/cart_item_model.dart';
import 'package:car_care/features/spare_parts_store/customer/cart/data/models/cart_model.dart';
import 'package:car_care/features/spare_parts_store/customer/cart/domain/entities/cart_entity.dart';

class CartRemoteDataSource {
  const CartRemoteDataSource(this._apiService);
  final ApiService _apiService;

  Future<CartItemModel> addToCart({
    required int productId,
    required int quantity,
  }) async {
    final response = await _apiService.post(
      endPoint: ApiEndpoints.customerCart,
      data: {'product_id': productId, 'quantity': quantity},
    );
    return CartItemModel.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<CartEntity> getCart() async {
    final response = await _apiService.get(endPoint: ApiEndpoints.customerCart);
    return CartModel.fromResponse(response);
  }

  Future<void> updateCartItem({
    required int cartItemId,
    required int quantity,
  }) async {
    final response = await _apiService.put(
      endPoint: ApiEndpoints.customerCartItemById(cartItemId),
      data: {'quantity': quantity},
    );
    _ensureSuccess(response);
  }

  Future<void> deleteCartItem(int cartItemId) async {
    final response = await _apiService.delete(
      endPoint: ApiEndpoints.customerCartItemById(cartItemId),
    );
    _ensureSuccess(response);
  }

  void _ensureSuccess(Map<String, dynamic> response) {
    if (response['success'] == false) {
      throw ServerExpcptions(
        error: Failure(
          message: (response['message'] ?? 'حدث خطأ غير متوقع').toString(),
        ),
      );
    }
  }
}
