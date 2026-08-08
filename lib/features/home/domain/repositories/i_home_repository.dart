import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';
import '../entities/home_entity.dart';

abstract class IHomeRepository {

  Future<Either<Failure, HomeEntity>> home(Map<String, dynamic> params);

}
