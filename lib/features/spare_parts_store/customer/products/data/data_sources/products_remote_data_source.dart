import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/spare_parts_store/customer/products/data/models/product_model.dart';

class ProductsRemoteDataSource {
  const ProductsRemoteDataSource(this._apiService);
  final ApiService _apiService;

  Future<ProductModel> getProductDetails(int id) async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.customerSpareProductById(id),
    );
    return ProductModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}
