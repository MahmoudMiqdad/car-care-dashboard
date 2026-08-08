import 'package:car_care/features/auth/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';

abstract class IAuthRepository {
  Future<Either<Failure, AdminEntity>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, AdminEntity>> getMe();
  Future<Either<Failure, void>> logout();
  Future<AdminEntity?> getCachedAdmin();
  Future<bool> isLoggedIn();
}