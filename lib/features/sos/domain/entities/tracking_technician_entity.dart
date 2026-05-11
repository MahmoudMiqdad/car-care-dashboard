import 'package:car_care/features/sos/data/models/tracking_techniciain_model.dart';

class TrackingTechnicianEntity {
  final int? sosId;
  final String? status;
  final double? lat;
  final double? lng;
  final List<LocationPoint>? path;

  TrackingTechnicianEntity({
    this.sosId,
    this.status,
    this.lat,
    this.lng,
    this.path,
  });
}