import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/spare_parts_store/customer/products/domain/entities/product_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/data/data_sources/shops_remote_data_source.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/domain/entities/shop_entity.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/domain/repositories/i_shops_repository.dart';
import 'package:dartz/dartz.dart';

class ShopsRepositoryImpl implements IShopsRepository {
  const ShopsRepositoryImpl(this._remote);
  final ShopsRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<ShopEntity>>> getShops({String? city}) async {
    try {
      final shops = await _remote.getShops(city: city);
      return Right(shops);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء جلب المتاجر'));
    }
  }

  @override
  Future<Either<Failure, ShopEntity>> getShopDetails(int shopId) async {
    try {
      final shop = await _remote.getShopDetails(shopId);
      return Right(shop);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء جلب تفاصيل المتجر'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getShopProducts(
    int shopId,
  ) async {
    try {
      final products = await _remote.getShopProducts(shopId);
      return Right(products);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء جلب منتجات المتجر'));
    }
  }
}
