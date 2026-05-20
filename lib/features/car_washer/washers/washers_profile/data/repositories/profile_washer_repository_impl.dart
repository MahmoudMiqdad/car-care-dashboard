import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/washer_profile_entity.dart';
import '../../domain/repositories/i_profile_washer_repository.dart';
import '../data_sources/profile_washer_remote_data_source.dart';

class ProfileWasherRepositoryImpl implements IProfileWasherRepository {
  const ProfileWasherRepositoryImpl(this._remote);
  final ProfileWasherRemoteDataSource _remote;

  @override
  Future<Either<Failure, WasherProfileEntity>> getMyProfile() async {
    try {
      final res = await _remote.getMyProfile();
      return Right(res);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء جلب بروفايل المغسلة'));
    }
  }

  @override
  Future<Either<Failure, WasherProfileEntity>> addOrUpdateProfile({
    required String shopName,
    required String phone,
    required String city,
    required String address,
    required String description,
    required List<String> services,
    required Map<String, int> servicePrices,
    required Map<String, String> workingHours,
  }) async {
    try {
      final res = await _remote.addOrUpdateProfile(
        shopName: shopName,
        phone: phone,
        city: city,
        address: address,
        description: description,
        services: services,
        servicePrices: servicePrices,
        workingHours: workingHours,
      );
      return Right(res);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء حفظ بروفايل المغسلة'));
    }
  }

  @override
  Future<Either<Failure, String>> uploadLogo(String filePath) async {
    try {
      final url = await _remote.uploadLogo(filePath);
      return Right(url);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء رفع الشعار'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLogo() async {
    try {
      await _remote.deleteLogo();
      return const Right(null);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء حذف الشعار'));
    }
  }
}
