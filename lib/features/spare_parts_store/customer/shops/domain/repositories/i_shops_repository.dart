import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/spare_parts_store/customer/products/domain/entities/product_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/domain/entities/shop_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IShopsRepository {
  Future<Either<Failure, List<ShopEntity>>> getShops({String? city});
  Future<Either<Failure, ShopEntity>> getShopDetails(int shopId);
  Future<Either<Failure, List<ProductEntity>>> getShopProducts(int shopId);
}
