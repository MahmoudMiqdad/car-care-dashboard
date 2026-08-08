import 'dart:convert';

import 'package:car_care/core/local_storage/secure_storage.dart';
import 'package:car_care/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:car_care/features/auth/data/models/auth_model.dart';

import 'package:car_care/features/auth/domain/entities/auth_entity.dart';
import 'package:car_care/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource _remote;
  final SecureStorage _storage;

  AuthRepositoryImpl(this._remote, this._storage);

  AdminEntity _mapAdmin(AdminUserModel? u) => AdminEntity(
        id: u?.id,
        uuid: u?.uuid,
        name: u?.name,
        email: u?.email,
        phone: u?.phone,
        status: u?.status,
        roles: u?.roles
                .map((r) => AdminRoleEntity(id: r.id, name: r.name, slug: r.slug))
                .toList() ??
            const [],
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
  Future<Either<Failure, AdminEntity>> login({
    required String email,
    required String password,
  }) {
    return _call(() async {
      final res = await _remote.login(email: email, password: password);
      final token = res.data?.token;
      final user = res.data?.user;

      if (token != null) {
        await _storage.setToken(token);
      }
      if (user != null) {
        await _storage.setUserName(jsonEncode(user.toJson()));
      }

      return _mapAdmin(user);
    });
  }

  @override
  Future<Either<Failure, AdminEntity>> getMe() {
    return _call(() async {
      final res = await _remote.getMe();
      if (res.data != null) {
        await _storage.setUserName(jsonEncode(res.data!.toJson()));
      }
      return _mapAdmin(res.data);
    });
  }

  @override
  Future<Either<Failure, void>> logout() {
    return _call(() async {
      try {
        await _remote.logout();
      } catch (_) {
        
      }
      await _storage.deleteToken();
      // await _storage.deleteValue();
    });
  }

  @override
  Future<AdminEntity?> getCachedAdmin() async {
    final raw = await _storage.getToken();
    if (raw == null) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return _mapAdmin(AdminUserModel.fromJson(json));
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _storage.getToken();
    return token != null && token.isNotEmpty;
  }
}