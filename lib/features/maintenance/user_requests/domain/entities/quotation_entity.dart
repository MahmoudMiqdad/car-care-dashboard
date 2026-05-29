import 'package:car_care/features/maintenance/user_requests/domain/entities/technician_request_entity.dart';

class QuotationRequestEntity {
  final int? id;
  final double? price;
  final String? priceFormatted;
  final int? estimatedDays;
  final String? notes;
  final bool? partsIncluded;
  final String? status;
  final String? statusText;
  final TechnicianRequestEntity? technician;
  final String? createdAt;
  final String? createdAgo;

  QuotationRequestEntity({
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
}