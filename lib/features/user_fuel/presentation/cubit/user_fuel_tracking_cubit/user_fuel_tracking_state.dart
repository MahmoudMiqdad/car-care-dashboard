import 'package:car_care/features/user_fuel/domain/entities/user_fuel_track_entity.dart';
import 'package:latlong2/latlong.dart';

abstract class UserFuelTrackingState {}

class UserFuelTrackingLoading extends UserFuelTrackingState {}

class UserFuelTrackingError extends UserFuelTrackingState {
  final String message;
  UserFuelTrackingError(this.message);
}

class UserFuelTrackingLoaded extends UserFuelTrackingState {
  final UserFuelTrackEntity data;
  final LatLng? liveLocation;
  UserFuelTrackingLoaded(this.data, {this.liveLocation});
}