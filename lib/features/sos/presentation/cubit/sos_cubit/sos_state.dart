import 'package:car_care/features/sos/domain/entities/sos_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SosState {}

class SosInitial extends SosState {}

class SosLoading extends SosState {}

class SosCreated extends SosState {
  final SosEntity sos;

  SosCreated(this.sos);
}
class SosCansel extends SosState {
  final String message;

  SosCansel(this.message);
}
class SosRequestLoaded extends SosState {
  final SosEntity sos;

  SosRequestLoaded(this.sos);
}
class SosListLoaded extends SosState {
  final List<SosEntity> listSOs;

  SosListLoaded(this.listSOs);
}

class SosError extends SosState {
  final String message;

  SosError(this.message);
}