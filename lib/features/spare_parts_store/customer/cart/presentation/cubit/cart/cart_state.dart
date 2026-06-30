import 'package:car_care/features/spare_parts_store/customer/cart/domain/entities/cart_entity.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  CartLoaded(
    this.cart, {
    this.quantityUpdatingItemIds = const {},
    this.deletingItemIds = const {},
    this.actionError,
  });

  final CartEntity cart;
  final Set<int> quantityUpdatingItemIds;
  final Set<int> deletingItemIds;
  final String? actionError;
}

class CartEmpty extends CartState {}

class CartError extends CartState {
  CartError(this.message);

  final String message;
}
