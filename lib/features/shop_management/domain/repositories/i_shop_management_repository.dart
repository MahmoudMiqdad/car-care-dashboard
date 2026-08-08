import 'package:car_care/features/shop_management/domain/entities/shop_management_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';

abstract class IShopRepository {
  Future<Either<Failure, List<ShopEntity>>> getShops({required String status});
  Future<Either<Failure, ShopEntity>> getShop(int id);
  Future<Either<Failure, ShopEntity>> approveShop(int id);
  Future<Either<Failure, ShopEntity>> rejectShop(int id, String reason);
  Future<Either<Failure, ShopEntity>> suspendShop(int id);
  Future<Either<Failure, ShopEntity>> reactivateShop(int id);
}