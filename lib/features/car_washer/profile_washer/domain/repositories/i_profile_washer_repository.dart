import 'package:car_care/core/errors/filuar.dart';
import 'package:dartz/dartz.dart';
import '../entities/washer_profile_entity.dart';

abstract class IProfileWasherRepository {
  Future<Either<Failure, WasherProfileEntity>> getMyProfile();

  Future<Either<Failure, WasherProfileEntity>> addOrUpdateProfile({
    required String shopName,
    required String phone,
    required String city,
    required String address,
    required String description,
    required List<String> services,
    required Map<String, int> servicePrices,
    required Map<String, String> workingHours,
  });

  Future<Either<Failure, String>> uploadLogo(String filePath);
  Future<Either<Failure, void>> deleteLogo();
}
