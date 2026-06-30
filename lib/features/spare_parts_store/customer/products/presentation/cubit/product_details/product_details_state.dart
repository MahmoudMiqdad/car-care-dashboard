import 'package:car_care/features/spare_parts_store/customer/products/domain/entities/product_entity.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  ProductDetailsLoaded(this.product);

  final ProductEntity product;
}

class ProductDetailsError extends ProductDetailsState {
  ProductDetailsError(this.message);

  final String message;
}
