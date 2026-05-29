
import 'package:car_care/features/maintenance/user_requests/data/models/location_trchician_model.dart';
class TechnicianRequestModel {
  final int? id;
  final String? name;
  final String? phone;
  final TechnicianProfileModel? profile;

  TechnicianRequestModel({
    this.id,
    this.name,
    this.phone,
    this.profile,
  });

  factory TechnicianRequestModel.fromJson(Map<String, dynamic> json) {
    return TechnicianRequestModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      profile: json['technician_profile'] != null
          ? TechnicianProfileModel.fromJson(json['technician_profile'])
          : null,
    );
  }
}
class TechnicianProfileModel {
  final String? specialization;
  final int? experienceYears;
  final LocationModel? location;

  TechnicianProfileModel({
    this.specialization,
    this.experienceYears,
    this.location,
  });

  factory TechnicianProfileModel.fromJson(Map<String, dynamic> json) {
    return TechnicianProfileModel(
      specialization: json['specialization'],
      experienceYears: json['experience_years'],
      location: json['current_location'] != null
          ? LocationModel.fromJson(json['current_location'])
          : null,
    );
  }
}
