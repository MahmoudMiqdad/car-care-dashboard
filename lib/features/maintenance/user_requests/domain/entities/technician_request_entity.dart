class TechnicianRequestEntity  {
  final int? id;
  final String? name;
  final String? phone;
  final TechnicianProfileEntity? profile;

  TechnicianRequestEntity({
    this.id,
    this.name,
    this.phone,
    this.profile,
  });
}
class TechnicianProfileEntity {
  final String? specialization;
  final int? experienceYears;
  final LocationEntity? location;

  TechnicianProfileEntity({
    this.specialization,
    this.experienceYears,
    this.location,
  });
}
class LocationEntity {
  final double? lat;
  final double? lng;
  final DateTime? updatedAt;

  LocationEntity({
    this.lat,
    this.lng,
    this.updatedAt,
  });
}