import 'package:car_care/features/spare_parts_store/customer/products/domain/entities/product_entity.dart';

abstract class ShopProductsState {}

class ShopProductsInitial extends ShopProductsState {}

class ShopProductsLoading extends ShopProductsState {}

class ShopProductsLoaded extends ShopProductsState {
  ShopProductsLoaded(this.products);

  final List<ProductEntity> products;
}

class ShopProductsEmpty extends ShopProductsState {}

class ShopProductsError extends ShopProductsState {
  ShopProductsError(this.message);

  final String message;
}
