
import 'package:car_care/features/maintenance/user_requests/data/models/location_trchician_model.dart';
import 'package:car_care/features/maintenance/user_requests/data/models/technician_profile_model.dart';
import 'package:car_care/features/maintenance/user_requests/domain/entities/technician_request_entity.dart';


extension   TechnicianRequestMapper on TechnicianRequestModel {
  TechnicianRequestEntity toEntity() {
    return TechnicianRequestEntity(
      id: id,
      name: name,
      phone: phone,
      profile: profile?.toEntity(),
    );
  }
}
extension TechnicianProfileMapper on TechnicianProfileModel {
  TechnicianProfileEntity toEntity() {
    return TechnicianProfileEntity(
      specialization: specialization,
      experienceYears: experienceYears,
      location: location?.toEntity(),
    );
  }
}
extension LocationMapper on LocationModel {
  LocationEntity toEntity() {
    return LocationEntity(
      lat: lat,
      lng: lng,
      updatedAt: updatedAt,
    );
  }
}