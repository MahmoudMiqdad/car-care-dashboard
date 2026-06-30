import 'package:car_care/features/spare_parts_store/customer/cart/domain/entities/cart_item_entity.dart';

abstract class AddToCartState {}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {}

class AddToCartSuccess extends AddToCartState {
  AddToCartSuccess(this.item);

  final CartItemEntity item;
}

class AddToCartError extends AddToCartState {
  AddToCartError(this.message);

  final String message;
}
