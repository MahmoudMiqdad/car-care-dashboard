import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';
import '../entities/provider_profile_entity.dart';

abstract class IProviderProfileRepository {

  Future<Either<Failure, ProviderProfileEntity>> providerProfile(Map<String, dynamic> params);

}
