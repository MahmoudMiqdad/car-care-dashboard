// واجهة مستودع ملف متجر المالك.
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/domain/entities/shop_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IOwnerProfileRepository {
  Future<Either<Failure, ShopEntity>> getProfile();

  Future<Either<Failure, ShopEntity>> saveProfile({
    required String name,
    required String phone,
    required String city,
    required List<int> businessTypeIds,
    required List<int> carBrandIds,
    required List<int> partCategoryIds,
  });
}
