import 'package:car_care/features/maintenance/user_requests/data/models/technician_profile_model.dart';

class QuotationRequestModel {
  final int? id;
  final double? price;
  final String? priceFormatted;
  final int? estimatedDays;
  final String? notes;
  final bool? partsIncluded;
  final String? status;
  final String? statusText;
  final TechnicianRequestModel? technician;
  final String? createdAt;
  final String? createdAgo;

 QuotationRequestModel({
    this.id,
    this.price,
    this.priceFormatted,
    this.estimatedDays,
    this.notes,
    this.partsIncluded,
    this.status,
    this.statusText,
    this.technician,
    this.createdAt,
    this.createdAgo,
  });

  factory QuotationRequestModel.fromJson(Map<String, dynamic> json) {
    return QuotationRequestModel(
      id: json['id'],
      price: (json['price'] as num?)?.toDouble(),
      priceFormatted: json['price_formatted'],
      estimatedDays: json['estimated_days'],
      notes: json['notes'],
      partsIncluded: json['parts_included'],
      status: json['status'],
      statusText: json['status_text'],
      technician: json['technician'] != null
          ? TechnicianRequestModel.fromJson(json['technician'])
          : null,
      createdAt: json['created_at'],
      createdAgo: json['created_ago'],
    );
  }
}
