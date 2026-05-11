import 'package:car_care/features/sos/domain/entities/tracking_technician_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';
import '../entities/sos_entity.dart';


abstract class ISosRepository {
  Future<Either<Failure, SosEntity>> createSos(Map<String, dynamic> data);

  Future<Either<Failure, List<SosEntity>>> getAll();

  Future<Either<Failure, SosEntity>> getSos(int id);

  Future<Either<Failure, Unit>> cancelSos(int id, String reason);
  Future<Either<Failure, TrackingTechnicianEntity>> trackSos(int id);
}