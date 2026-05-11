import 'package:car_care/features/sos/domain/entities/sos_entity.dart';

abstract class SosState {}

class SosInitial extends SosState {}

class SosLoading extends SosState {}

class SosCreated extends SosState {
  final SosEntity sos;

  SosCreated(this.sos);
}

class SosListLoaded extends SosState {
  final List<SosEntity> list;

  SosListLoaded(this.list);
}

class SosError extends SosState {
  final String message;

  SosError(this.message);
}