// current_location_entity.dart
class CurrentLocationEntity {
  final double lat;
  final double lng;
  final String updatedAt;

  CurrentLocationEntity({
    required this.lat,
    required this.lng,
    required this.updatedAt,
  });
}

// technician_entity.dart
class TechnicianEntity {
  final int id;
  final String name;
  final String phone;
  final TechnicianProfileEntity technicianProfile;

  TechnicianEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.technicianProfile,
  });
}

class TechnicianProfileEntity {
  final String specialization;
  final int experienceYears;
  final CurrentLocationEntity? currentLocation;

  TechnicianProfileEntity({
    required this.specialization,
    required this.experienceYears,
    this.currentLocation,
  });
}