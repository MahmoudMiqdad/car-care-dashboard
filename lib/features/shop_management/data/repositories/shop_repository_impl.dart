import 'package:car_care/features/shop_management/data/data_sources/shop_management_remote_data_source.dart';

import 'package:car_care/features/shop_management/data/models/shop_model.dart';

import 'package:car_care/features/shop_management/domain/entities/shop_management_entity.dart';
import 'package:car_care/features/shop_management/domain/repositories/i_shop_management_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';

class ShopRepositoryImpl implements IShopRepository {
  final ShopRemoteDataSource _remote;
  ShopRepositoryImpl(this._remote);

  ShopEntity _mapShop(ShopData? d) => ShopEntity(
        id: d?.id,
        name: d?.name,
        phone: d?.phone,
        city: d?.city,
        isActive: d?.isActive,
        status: d?.status,
        rejectionReason: d?.rejectionReason,
        approvedAt: d?.approvedAt,
        rejectedAt: d?.rejectedAt,
        suspendedAt: d?.suspendedAt,
        businessTypes: d?.businessTypes ?? const [],
        carBrands: d?.carBrands ?? const [],
        partCategories: d?.partCategories ?? const [],
        createdAt: d?.createdAt,
        owner: d?.owner != null
            ? ShopOwnerEntity(id: d!.owner!.id, name: d.owner!.name, email: d.owner!.email)
            : null,
      );

  Future<Either<Failure, T>> _call<T>(Future<T> Function() fn) async {
    try {
      return Right(await fn());
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ShopEntity>>> getShops({required String status}) =>
      _call(() async => (await _remote.getShops(status: status)).data.map(_mapShop).toList());

  @override
  Future<Either<Failure, ShopEntity>> getShop(int id) =>
      _call(() async => _mapShop((await _remote.getShop(id)).data));

  @override
  Future<Either<Failure, ShopEntity>> approveShop(int id) =>
      _call(() async => _mapShop((await _remote.approveShop(id)).data));

  @override
  Future<Either<Failure, ShopEntity>> rejectShop(int id, String reason) =>
      _call(() async => _mapShop((await _remote.rejectShop(id, reason)).data));

  @override
  Future<Either<Failure, ShopEntity>> suspendShop(int id) =>
      _call(() async => _mapShop((await _remote.suspendShop(id)).data));

  @override
  Future<Either<Failure, ShopEntity>> reactivateShop(int id) =>
      _call(() async => _mapShop((await _remote.reactivateShop(id)).data));
}