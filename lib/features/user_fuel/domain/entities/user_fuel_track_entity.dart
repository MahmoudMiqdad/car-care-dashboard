
class UserFuelTrackEntity {
  final int? orderId;
  final String? orderStatus;
  final UserFuelTrackProviderEntity? provider;
  final UserFuelTrackLocationEntity? currentLocation;
  final List<UserFuelTrackLocationEntity> trackingPath;

  UserFuelTrackEntity({
    this.orderId, this.orderStatus, this.provider,
    this.currentLocation, required this.trackingPath,
  });
}

class UserFuelTrackProviderEntity {
  final int? id;
  final String? companyName;
  final String? phone;

  UserFuelTrackProviderEntity({this.id, this.companyName, this.phone});
}

class UserFuelTrackLocationEntity {
  final double? latitude;
  final double? longitude;
  final String? timestamp;

  UserFuelTrackLocationEntity({this.latitude, this.longitude, this.timestamp});
}