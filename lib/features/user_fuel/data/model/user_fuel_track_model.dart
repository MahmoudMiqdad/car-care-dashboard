

class UserFuelTrackModel {
  final bool? success;
  final UserFuelTrackData? data;

  UserFuelTrackModel({this.success, this.data});

  factory UserFuelTrackModel.fromJson(Map<String, dynamic> json) =>
      UserFuelTrackModel(
        success: json['success'],
        data: json['data'] != null
            ? UserFuelTrackData.fromJson(json['data'])
            : null,
      );
}

class UserFuelTrackData {
  final int? orderId;
  final String? orderStatus;
  final UserFuelTrackProvider? provider;
  final UserFuelTrackLocation? currentLocation;
  final List<UserFuelTrackLocation> trackingPath;

  UserFuelTrackData({
    this.orderId, this.orderStatus, this.provider,
    this.currentLocation, required this.trackingPath,
  });

  factory UserFuelTrackData.fromJson(Map<String, dynamic> json) =>
      UserFuelTrackData(
        orderId: json['order_id'],
        orderStatus: json['order_status'],
        provider: json['provider'] != null
            ? UserFuelTrackProvider.fromJson(json['provider'])
            : null,
        currentLocation: json['current_location'] != null
            ? UserFuelTrackLocation.fromJson(json['current_location'])
            : null,
        trackingPath: json['tracking_path'] != null
            ? List.from(json['tracking_path'])
                .map((e) => UserFuelTrackLocation.fromJson(e))
                .toList()
            : [],
      );
}

class UserFuelTrackProvider {
  final int? id;
  final String? companyName;
  final String? phone;

  UserFuelTrackProvider({this.id, this.companyName, this.phone});

  factory UserFuelTrackProvider.fromJson(Map<String, dynamic> json) =>
      UserFuelTrackProvider(
        id: json['id'],
        companyName: json['company_name'],
        phone: json['phone'],
      );
}

class UserFuelTrackLocation {
  final double? latitude;
  final double? longitude;
  final String? timestamp;

  UserFuelTrackLocation({this.latitude, this.longitude, this.timestamp});

  factory UserFuelTrackLocation.fromJson(Map<String, dynamic> json) =>
      UserFuelTrackLocation(
        latitude: double.tryParse(
            (json['latitude'] ?? json['lat']).toString()),
        longitude: double.tryParse(
            (json['longitude'] ?? json['lng']).toString()),
        timestamp: json['timestamp'] ?? json['last_updated'],
      );
}