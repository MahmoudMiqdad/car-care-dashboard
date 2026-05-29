import 'package:car_care/features/sos/domain/entities/tracking_technician_entity.dart';
import 'package:latlong2/latlong.dart';

abstract class TrackingState {}

class TrackingInitial extends TrackingState {}

class TrackingLoading extends TrackingState {}

class TrackingLoaded extends TrackingState {
  final TrackingTechnicianEntity data;
  final LatLng? liveLocation;

  TrackingLoaded(this.data, {this.liveLocation});

  TrackingLoaded copyWith({LatLng? liveLocation}) {
    return TrackingLoaded(
      data,
      liveLocation: liveLocation ?? this.liveLocation,
    );
  }
}


class TrackingWaitingTechnician extends TrackingState {}

class TrackingError extends TrackingState {
  final String message;
  TrackingError(this.message);
}