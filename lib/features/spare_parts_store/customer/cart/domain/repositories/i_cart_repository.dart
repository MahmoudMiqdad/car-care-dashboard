import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/spare_parts_store/customer/cart/domain/entities/cart_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/cart/domain/entities/cart_item_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ICartRepository {
  Future<Either<Failure, CartItemEntity>> addToCart({
    required int productId,
    required int quantity,
  });

  Future<Either<Failure, CartEntity>> getCart();

  Future<Either<Failure, void>> updateCartItem({
    required int cartItemId,
    required int quantity,
  });

  Future<Either<Failure, void>> deleteCartItem(int cartItemId);
}
