import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';
import '../entities/technician_sos_entity.dart';

abstract class ITechnicianSosRepository {

  Future<Either<Failure, TechnicianSosEntity>> technicianSos(Map<String, dynamic> params);

}
