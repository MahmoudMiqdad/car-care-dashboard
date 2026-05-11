class TrackingTechniciainModel {
  final bool? success;
  final TrackingData? data;

  TrackingTechniciainModel({this.success, this.data});

  factory TrackingTechniciainModel.fromJson(Map<String, dynamic> json) =>
      TrackingTechniciainModel(
        success: json['success'],
        data: json['data'] != null
            ? TrackingData.fromJson(json['data'])
            : null,
      );
}

class TrackingData {
  final SosRequest? sosRequest;
  final Technician? technician;
  final Location? lastLocation;
  final List<LocationPoint>? path;

  TrackingData({
    this.sosRequest,
    this.technician,
    this.lastLocation,
    this.path,
  });

  factory TrackingData.fromJson(Map<String, dynamic> json) => TrackingData(
        sosRequest: json['sos_request'] != null
            ? SosRequest.fromJson(json['sos_request'])
            : null,
        technician: json['technician'] != null
            ? Technician.fromJson(json['technician'])
            : null,
        lastLocation: json['last_location'] != null
            ? Location.fromJson(json['last_location'])
            : null,
        path: json['tracking_path'] != null
            ? List.from(json['tracking_path'])
                .map((e) => LocationPoint.fromJson(e))
                .toList()
            : [],
      );
}

class SosRequest {
  final int? id;
  final String? status;

  SosRequest({this.id, this.status});

  factory SosRequest.fromJson(Map<String, dynamic> json) => SosRequest(
        id: json['id'],
        status: json['status'],
      );
}

class Technician {
  final int? id;
  final String? name;
  final String? phone;

  Technician({this.id, this.name, this.phone});

  factory Technician.fromJson(Map<String, dynamic> json) => Technician(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
      );
}

class Location {
  final double? lat;
  final double? lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: double.tryParse(json['lat'].toString()),
        lng: double.tryParse(json['lng'].toString()),
      );
}

class LocationPoint {
  final double lat;
  final double lng;

  LocationPoint({required this.lat, required this.lng});

  factory LocationPoint.fromJson(Map<String, dynamic> json) =>
      LocationPoint(
        lat: double.tryParse(json['lat'].toString()) ?? 0,
        lng: double.tryParse(json['lng'].toString()) ?? 0,
      );
}