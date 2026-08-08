class FuelProviderEntity {
  final int? id;
  final String? companyName;
  final String? phone;
  final String? city;
  final String? address;
  final double? latitude;
  final double? longitude;
  final List<String> fuelTypes;
  final Map<String, dynamic> prices;
  final bool? isAvailable;
  final bool? isVerified;
  final String? status;
  final String? rejectionReason;
  final String? approvedAt;
  final String? rejectedAt;
  final String? suspendedAt;
  final FuelProviderUserEntity? user;
  final String? createdAt;

  const FuelProviderEntity({
    this.id,
    this.companyName,
    this.phone,
    this.city,
    this.address,
    this.latitude,
    this.longitude,
    this.fuelTypes = const [],
    this.prices = const {},
    this.isAvailable,
    this.isVerified,
    this.status,
    this.rejectionReason,
    this.approvedAt,
    this.rejectedAt,
    this.suspendedAt,
    this.user,
    this.createdAt,
  });
}

class FuelProviderUserEntity {
  final int? id;
  final String? name;
  final String? email;

  const FuelProviderUserEntity({this.id, this.name, this.email});
}