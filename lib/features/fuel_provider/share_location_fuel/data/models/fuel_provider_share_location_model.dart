
class FuelTrackingModel {
  final bool? success;
  final FuelTrackingData? data;

  FuelTrackingModel({this.success, this.data});

  factory FuelTrackingModel.fromJson(Map<String, dynamic> json) =>
      FuelTrackingModel(
        success: json['success'],
        data: json['data'] != null
            ? FuelTrackingData.fromJson(json['data'])
            : null,
      );
}

class FuelTrackingData {
  final int? orderId;
  final String? orderStatus;
  final FuelTrackingProvider? provider;
  final FuelTrackingLocation? currentLocation;
  final List<FuelTrackingPathPoint> trackingPath;

  FuelTrackingData({
    this.orderId,
    this.orderStatus,
    this.provider,
    this.currentLocation,
    this.trackingPath = const [],
  });

  factory FuelTrackingData.fromJson(Map<String, dynamic> json) =>
      FuelTrackingData(
        orderId: json['order_id'],
        orderStatus: json['order_status'],
        provider: json['provider'] != null
            ? FuelTrackingProvider.fromJson(json['provider'])
            : null,
        currentLocation: json['current_location'] != null
            ? FuelTrackingLocation.fromJson(json['current_location'])
            : null,
        trackingPath: json['tracking_path'] != null
            ? List<FuelTrackingPathPoint>.from(
                (json['tracking_path'] as List)
                    .map((e) => FuelTrackingPathPoint.fromJson(e)),
              )
            : [],
      );
}

class FuelTrackingProvider {
  final int? id;
  final String? companyName;
  final String? phone;

  FuelTrackingProvider({this.id, this.companyName, this.phone});

  factory FuelTrackingProvider.fromJson(Map<String, dynamic> json) =>
      FuelTrackingProvider(
        id: json['id'],
        companyName: json['company_name'],
        phone: json['phone'],
      );
}

class FuelTrackingLocation {
  final double? latitude;
  final double? longitude;
  final String? lastUpdated;

  FuelTrackingLocation({this.latitude, this.longitude, this.lastUpdated});

  factory FuelTrackingLocation.fromJson(Map<String, dynamic> json) =>
      FuelTrackingLocation(
        latitude: double.tryParse(json['latitude'].toString()),
        longitude: double.tryParse(json['longitude'].toString()),
        lastUpdated: json['last_updated'],
      );
}

class FuelTrackingPathPoint {
  final double? latitude;
  final double? longitude;
  final String? timestamp;

  FuelTrackingPathPoint({this.latitude, this.longitude, this.timestamp});

  factory FuelTrackingPathPoint.fromJson(Map<String, dynamic> json) =>
      FuelTrackingPathPoint(
        latitude: double.tryParse(json['latitude'].toString()),
        longitude: double.tryParse(json['longitude'].toString()),
        timestamp: json['timestamp'],
      );
}
