import 'package:car_care/features/technician_management/data/data_sources/technician_remote_data_source.dart';
import 'package:car_care/features/technician_management/data/models/technician_model.dart';
import 'package:car_care/features/technician_management/domain/entities/technician_entity.dart';
import 'package:car_care/features/technician_management/domain/repositories/i_technician_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';


class TechnicianRepositoryImpl implements ITechnicianRepository {
  final TechnicianRemoteDataSource _remote;
  TechnicianRepositoryImpl(this._remote);

  TechnicianEntity _mapTechnician(TechnicianData? d) => TechnicianEntity(
        id: d?.id,
        userId: d?.userId,
        specialization: d?.specialization,
        experienceYears: d?.experienceYears,
        phone: d?.phone,
        city: d?.city,
        hourlyRate: d?.hourlyRate,
        isAvailable: d?.isAvailable,
        status: d?.status,
        rejectionReason: d?.rejectionReason,
        approvedAt: d?.approvedAt,
        rejectedAt: d?.rejectedAt,
        suspendedAt: d?.suspendedAt,
        certifications: d?.certifications ?? const [],
        createdAt: d?.createdAt,
        updatedAt: d?.updatedAt,
        user: d?.user != null
            ? TechnicianUserEntity(
                id: d!.user!.id,
                name: d.user!.name,
                email: d.user!.email,
              )
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
  Future<Either<Failure, List<TechnicianEntity>>> getTechnicians({required String status}) =>
      _call(() async =>
          (await _remote.getTechnicians(status: status)).data.map(_mapTechnician).toList());

  @override
  Future<Either<Failure, TechnicianEntity>> getTechnician(int id) =>
      _call(() async => _mapTechnician((await _remote.getTechnician(id)).data));

  @override
  Future<Either<Failure, TechnicianEntity>> approveTechnician(int id) =>
      _call(() async => _mapTechnician((await _remote.approveTechnician(id)).data));

  @override
  Future<Either<Failure, TechnicianEntity>> rejectTechnician(int id, String reason) =>
      _call(() async => _mapTechnician((await _remote.rejectTechnician(id, reason)).data));

  @override
  Future<Either<Failure, TechnicianEntity>> suspendTechnician(int id) =>
      _call(() async => _mapTechnician((await _remote.suspendTechnician(id)).data));

  @override
  Future<Either<Failure, TechnicianEntity>> reactivateTechnician(int id) =>
      _call(() async => _mapTechnician((await _remote.reactivateTechnician(id)).data));
}
