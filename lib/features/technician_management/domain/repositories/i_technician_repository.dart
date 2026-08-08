import 'package:car_care/features/technician_management/domain/entities/technician_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';

abstract class ITechnicianRepository {
  Future<Either<Failure, List<TechnicianEntity>>> getTechnicians({required String status});
  Future<Either<Failure, TechnicianEntity>> getTechnician(int id);
  Future<Either<Failure, TechnicianEntity>> approveTechnician(int id);
  Future<Either<Failure, TechnicianEntity>> rejectTechnician(int id, String reason);
  Future<Either<Failure, TechnicianEntity>> suspendTechnician(int id);
  Future<Either<Failure, TechnicianEntity>> reactivateTechnician(int id);
}
