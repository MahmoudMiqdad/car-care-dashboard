import 'package:car_care/features/spare_parts_store/customer/products/domain/entities/product_entity.dart';

abstract class AllProductsState {}

class AllProductsInitial extends AllProductsState {}

class AllProductsLoading extends AllProductsState {}

class AllProductsLoaded extends AllProductsState {
  AllProductsLoaded(this.products);

  final List<ProductEntity> products;
}

class AllProductsEmpty extends AllProductsState {}

class AllProductsError extends AllProductsState {
  AllProductsError(this.message);

  final String message;
}
