import 'package:car_care/features/technician_management/domain/entities/technician_entity.dart';

abstract class TechnicianState {}

class TechnicianInitial extends TechnicianState {}

class TechnicianLoading extends TechnicianState {}


class TechnicianListActionLoading extends TechnicianState {
  final List<TechnicianEntity> technicians;
  final String currentFilter;
  final int actionTechnicianId;
  TechnicianListActionLoading(this.technicians, this.currentFilter, this.actionTechnicianId);
}

class TechnicianListLoaded extends TechnicianState {
  final List<TechnicianEntity> technicians;
  final String currentFilter;
  TechnicianListLoaded(this.technicians, this.currentFilter);
}

class TechnicianDetailsLoaded extends TechnicianState {
  final TechnicianEntity technician;
  TechnicianDetailsLoaded(this.technician);
}

class TechnicianActionSuccess extends TechnicianState {
  final TechnicianEntity technician;
  final String message;
  final List<TechnicianEntity> technicians;
  final String currentFilter;
  TechnicianActionSuccess(
    this.technician,
    this.message,
    this.technicians,
    this.currentFilter,
  );
}

class TechnicianError extends TechnicianState {
  final String message;
  TechnicianError(this.message);
}
