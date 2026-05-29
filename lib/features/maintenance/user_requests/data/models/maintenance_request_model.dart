import 'package:car_care/features/maintenance/user_requests/data/models/quotation_model.dart';
import 'package:car_care/features/maintenance/user_requests/data/models/request_image_model.dart';
import 'package:car_care/features/maintenance/user_requests/data/models/vehicle_model.dart';

class MaintenanceRequestModel {
  final bool? success;
  final String? message;
  final List<MaintenanceRequestData> data;

  MaintenanceRequestModel({
    this.success,
    this.message,
    required this.data,
  });

  factory MaintenanceRequestModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return MaintenanceRequestModel(data: []);
    }

    return MaintenanceRequestModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] != null
          ? List<MaintenanceRequestData>.from(
              json["data"].map((x) => MaintenanceRequestData.fromJson(x)))
          : [],
    );
  }
}
class MaintenanceRequestData {
  final int? id;
  final String? description;
  final String? priority;
  final String? priorityText;
  final String? status;
  final String? statusText;
  final VehicleModel? vehicle;
  final List<RequestImageModel> images;
  final List<QuotationRequestModel> quotations;
  final DateTime? preferredDate;
  final DateTime? createdAt;
  final String? createdAgo;
  final bool? canCancel;

  MaintenanceRequestData({
    this.id,
    this.description,
    this.priority,
    this.priorityText,
    this.status,
    this.statusText,
    this.vehicle,
    required this.images,
    required this.quotations,
    this.preferredDate,
    this.createdAt,
    this.createdAgo,
    this.canCancel,
  });

  factory MaintenanceRequestData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return MaintenanceRequestData(images: [], quotations: []);

    return MaintenanceRequestData(
      id: json["id"],
      description: json["description"],
      priority: json["priority"],
      priorityText: json["priority_text"],
      status: json["status"],
      statusText: json["status_text"],
      vehicle: json["vehicle"] != null
          ? VehicleModel.fromJson(json["vehicle"])
          : null,
      images: json["images"] != null
          ? List<RequestImageModel>.from(
              json["images"].map((x) => RequestImageModel.fromJson(x)))
          : [],
      quotations: json["quotations"] != null
          ? List<QuotationRequestModel>.from(
              json["quotations"].map((x) => QuotationRequestModel.fromJson(x)))
          : [],
      preferredDate: json["preferred_date"] != null
          ? DateTime.tryParse(json["preferred_date"])
          : null,
      createdAt: json["created_at"] != null
          ? DateTime.tryParse(json["created_at"])
          : null,
      createdAgo: json["created_ago"],
      canCancel: json["can_cancel"],
    );
  }
}