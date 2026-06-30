import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/spare_parts_store/customer/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:car_care/features/spare_parts_store/customer/cart/domain/entities/cart_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/cart/domain/entities/cart_item_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/cart/domain/repositories/i_cart_repository.dart';
import 'package:dartz/dartz.dart';

class CartRepositoryImpl implements ICartRepository {
  const CartRepositoryImpl(this._remote);
  final CartRemoteDataSource _remote;

  @override
  Future<Either<Failure, CartItemEntity>> addToCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      final item = await _remote.addToCart(
        productId: productId,
        quantity: quantity,
      );
      return Right(item);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء إضافة المنتج إلى السلة'));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> getCart() async {
    try {
      final cart = await _remote.getCart();
      return Right(cart);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء جلب السلة'));
    }
  }

  @override
  Future<Either<Failure, void>> updateCartItem({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      await _remote.updateCartItem(cartItemId: cartItemId, quantity: quantity);
      return const Right(null);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء تحديث الكمية'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCartItem(int cartItemId) async {
    try {
      await _remote.deleteCartItem(cartItemId);
      return const Right(null);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء حذف العنصر من السلة'));
    }
  }
}
