import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/sos/data/data_sources/sos_remote_data_source.dart';
import 'package:car_care/features/sos/data/models/sos_model.dart';
import 'package:car_care/features/sos/domain/entities/sos_entity.dart';
import 'package:car_care/features/sos/domain/entities/tracking_technician_entity.dart';
import 'package:car_care/features/sos/domain/repositories/i_sos_repository.dart';
import 'package:dartz/dartz.dart';
class SosRepositoryImpl implements ISosRepository {
  final SosRemoteDataSource _remote;

  SosRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, SosEntity>> createSos(data) async {
    try {
      final result = await _remote.createSos(data);

      return Right(_mapToEntity(result.data));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SosEntity>>> getAll() async {
    try {
      final result = await _remote.getAllSos();

      return Right(result.map(_mapToEntity).toList());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SosEntity>> getSos(int id) async {
    try {
      final result = await _remote.getSos(id);

      return Right(_mapToEntity(result));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> cancelSos(int id, String reason) async {
    try {
      await _remote.cancelSos(id, reason);

      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  SosEntity _mapToEntity(SosData? data) {
    return SosEntity(
      id: data?.id,
      lat: data?.lat,
      lng: data?.lng,
      description: data?.description,
      status: data?.status,
    );
  }
  @override
Future<Either<Failure, TrackingTechnicianEntity>> trackSos(int id) async {
  try {
    final result = await _remote.trackSos(id);

    return Right(
      TrackingTechnicianEntity(
        sosId: result.sosRequest?.id,
        status: result.sosRequest?.status,
        lat: result.lastLocation?.lat,
        lng: result.lastLocation?.lng,
        path: result.path,
      ),
    );
  } catch (e) {
    return Left(Failure(message: e.toString()));
  }
}
}