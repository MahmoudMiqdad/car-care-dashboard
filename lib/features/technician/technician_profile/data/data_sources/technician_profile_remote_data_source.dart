import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/technician/technician_profile/data/models/technician_availability_model.dart';
import 'package:car_care/features/technician/technician_profile/data/models/technician_profile.dart';
import 'package:dio/dio.dart';

class TechnicianProfileRemoteDataSource {
  const TechnicianProfileRemoteDataSource(this._apiService);

  final ApiService _apiService;

  Future<TechnicianProfile> showProfile() async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.technicianprofile,
    );
    return TechnicianProfile.fromJson(response);
  }

  Future<TechnicianProfile> insertTechnicianProfile(
      Map<String, dynamic> data) async {
   
    final formData = await _buildFormData(data);

    final response = await _apiService.post(
      endPoint: ApiEndpoints.inserttechnicianprofile,
      data: formData,
      isFormData: true,
    );
    return TechnicianProfile.fromJson(response);
  }

  Future<TechnicianProfile> updateTechnicianProfile(
      Map<String, dynamic> data) async {

    final formData = await _buildFormData(data);

    final response = await _apiService.post(
      endPoint: ApiEndpoints.updatetechnicianprofile,
      data: formData,
      isFormData: true,
    );
    return TechnicianProfile.fromJson(response);
  }

  Future<TechnicianAvailabilityModel> changeAvailability(
      String isAvailable) async {
    final response = await _apiService.patch(
      endPoint: ApiEndpoints.technicianavAilability,
      data: {"is_available": isAvailable},
    );
    return TechnicianAvailabilityModel.fromJson(response);
  }

  Future<Map<String, dynamic>> _buildFormData(
      Map<String, dynamic> data) async {
    final Map<String, dynamic> formFields = {};

    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;

      // إذا الـ value مسار صورة (certifications[0], certifications[1]...)
      if (key.startsWith('certifications[') && value is String) {
        formFields[key] = await MultipartFile.fromFile(
          value,
          filename: value.split('/').last,
        );
      } else {
        formFields[key] = value;
      }
    }

    return formFields;
  }
}