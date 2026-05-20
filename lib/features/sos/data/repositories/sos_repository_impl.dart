import 'package:car_care/core/errors/excptions.dart';
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

      final entity = _mapToEntity(result.data);

      if (entity == null) {
        return Left(Failure(message: "Invalid SOS response"));
      }

      return Right(entity);
    } on ServerExpcptions catch (e) {
    return Left(e.error);
  } catch (_) {
    return const Left(Failure(message: 'حدث خطأ غير متوقع'));
  }
  }

  @override
  Future<Either<Failure, List<SosEntity>>> getAll() async {
    try {
      final result = await _remote.getAllSos(); // List<SosData>

      final entities = result
          .map(_mapToEntity)
          .whereType<SosEntity>()
          .toList();

      return Right(entities);
    } on ServerExpcptions catch (e) {
    return Left(e.error);
  } catch (_) {
    return const Left(Failure(message: 'حدث خطأ غير متوقع'));
  }
  }

  @override
  Future<Either<Failure, SosEntity>> getSosRequest(int id) async {
    try {
      final result = await _remote.getSosRequest(id);

      final entity = _mapToEntity(result);

      if (entity == null) {
        return Left(Failure(message: "SOS not found"));
      }

      return Right(entity);
    } on ServerExpcptions catch (e) {
    return Left(e.error);
  } catch (_) {
    return const Left(Failure(message: 'حدث خطأ غير متوقع'));
  }
  }

  @override
  Future<Either<Failure, Unit>> cancelSos(int id, String reason) async {
    try {
      await _remote.cancelSos(id, reason);
      return const Right(unit);
    } on ServerExpcptions catch (e) {
    return Left(e.error);
  } catch (_) {
    return const Left(Failure(message: 'حدث خطأ غير متوقع'));
  }
  }

  @override
  Future<Either<Failure, TrackingTechnicianEntity>> trackSos(int id) async {
    try {
      final result = await _remote.trackSos(id);

      return Right(
        TrackingTechnicianEntity(
          sosId: result.sosRequest?.id,
          status: result.sosRequest?.status ?? '',
          lat: result.lastLocation?.lat,
          lng: result.lastLocation?.lng,
          path: result.path ?? [],
        ),
      );
    } on ServerExpcptions catch (e) {
    return Left(e.error);
  } catch (_) {
    return const Left(Failure(message: 'حدث خطأ غير متوقع'));
  }
  }


SosEntity? _mapToEntity(SosData? data) {
  if (data == null) return null;

  final vehicle = data.vehicle;
  final tech = data.technician;

  return SosEntity(
    id: data.id,
    lat: data.lat,
    lng: data.lng,

    description: data.description,
    status: data.status,
    statusText: data.statusText,
    priority: data.priority,

    // vehicle
    vehicleId: vehicle?.id,
    vehicleBrand: vehicle?.brand,
    vehicleModel: vehicle?.model,
    vehicleYear: vehicle?.year,
    plateNumber: vehicle?.plateNumber,
    currentKm: vehicle?.currentKm,
    vehicleImage: vehicle?.image,
    vehicleImagePath: vehicle?.imagePath,
    vehicleStatus: vehicle?.status,
    needsMaintenance: vehicle?.needsMaintenance,

    // owner
    ownerId: vehicle?.owner?.id,
    ownerName: vehicle?.owner?.name,

    // technician
    technicianId: tech?.id,
    technicianName: tech?.name,
    technicianPhone: tech?.phone,

    canCancel: data.canCancel,

    createdAt: data.createdAt,
    createdAgo: data.createdAgo,
  );
}
}