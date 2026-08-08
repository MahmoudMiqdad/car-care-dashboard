
import 'package:car_care/features/carwasher_management/domain/entities/carwasher_management_entity.dart';

abstract class CarwasherState {}

class CarwasherInitial extends CarwasherState {}

class CarwasherLoading extends CarwasherState {}

class CarwasherListActionLoading extends CarwasherState {
  final List<CarwasherEntity> carwashers;
  final String currentFilter;
  final int actionCarwasherId;
  CarwasherListActionLoading(this.carwashers, this.currentFilter, this.actionCarwasherId);
}

class CarwasherListLoaded extends CarwasherState {
  final List<CarwasherEntity> carwashers;
  final String currentFilter;
  CarwasherListLoaded(this.carwashers, this.currentFilter);
}

class CarwasherDetailsLoaded extends CarwasherState {
  final CarwasherEntity carwasher;
  CarwasherDetailsLoaded(this.carwasher);
}

class CarwasherActionSuccess extends CarwasherState {
  final CarwasherEntity carwasher;
  final String message;
  final List<CarwasherEntity> carwashers;
  final String currentFilter;
  CarwasherActionSuccess(this.carwasher, this.message, this.carwashers, this.currentFilter);
}

class CarwasherError extends CarwasherState {
  final String message;
  CarwasherError(this.message);
}