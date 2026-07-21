// تنفيذ مستودع ملف متجر المالك.
import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/spare_parts_store/customer/shops/domain/entities/shop_entity.dart';
import 'package:car_care/features/spare_parts_store/owner/profile/data/data_sources/owner_profile_remote_data_source.dart';
import 'package:car_care/features/spare_parts_store/owner/profile/domain/repositories/i_owner_profile_repository.dart';
import 'package:dartz/dartz.dart';

class OwnerProfileRepositoryImpl implements IOwnerProfileRepository {
  const OwnerProfileRepositoryImpl(this._dataSource);

  final OwnerProfileRemoteDataSource _dataSource;

  @override
  Future<Either<Failure, ShopEntity>> getProfile() async {
    try {
      return Right(await _dataSource.getProfile());
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء جلب ملف المتجر'));
    }
  }

  @override
  Future<Either<Failure, ShopEntity>> saveProfile({
    required String name,
    required String phone,
    required String city,
    required List<int> businessTypeIds,
    required List<int> carBrandIds,
    required List<int> partCategoryIds,
  }) async {
    try {
      return Right(await _dataSource.saveProfile(
        name: name,
        phone: phone,
        city: city,
        businessTypeIds: businessTypeIds,
        carBrandIds: carBrandIds,
        partCategoryIds: partCategoryIds,
      ));
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء حفظ ملف المتجر'));
    }
  }
}
