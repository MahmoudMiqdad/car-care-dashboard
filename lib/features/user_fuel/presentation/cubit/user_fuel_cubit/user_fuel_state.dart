// user_fuel_state.dart
import 'package:car_care/features/user_fuel/domain/entities/user_fuel_order_entity.dart';
import 'package:car_care/features/user_fuel/domain/entities/user_fuel_track_entity.dart';

abstract class UserFuelState {}

class UserFuelInitial extends UserFuelState {}

class UserFuelLoading extends UserFuelState {}

class UserFuelOrdersLoaded extends UserFuelState {
  final List<UserFuelOrderEntity> orders;
  UserFuelOrdersLoaded(this.orders);
}

class UserFuelOrderLoaded extends UserFuelState {
  final UserFuelOrderEntity order;
  UserFuelOrderLoaded(this.order);
}

class UserFuelOrderCreated extends UserFuelState {
  final UserFuelOrderEntity order;
  UserFuelOrderCreated(this.order);
}

class UserFuelOrderCancelled extends UserFuelState {}

class UserFuelTrackLoaded extends UserFuelState {
  final UserFuelTrackEntity track;
  UserFuelTrackLoaded(this.track);
}

class UserFuelError extends UserFuelState {
  final String message;
  UserFuelError(this.message);
}