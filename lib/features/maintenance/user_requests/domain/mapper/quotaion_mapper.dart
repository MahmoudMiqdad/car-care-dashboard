

import 'package:car_care/features/maintenance/user_requests/data/models/quotation_model.dart';
import 'package:car_care/features/maintenance/user_requests/domain/entities/quotation_entity.dart';
import 'package:car_care/features/maintenance/user_requests/domain/mapper/technician_mapper.dart';
extension QuotationMapper on QuotationRequestModel {
  QuotationRequestEntity toEntity() {
    return QuotationRequestEntity(
      id: id,
      price: price,
      priceFormatted: priceFormatted,
      estimatedDays: estimatedDays,
      notes: notes,
      partsIncluded: partsIncluded,
      status: status,
      statusText: statusText,
      technician: technician?.toEntity(),
      createdAt: createdAt,
      createdAgo: createdAgo,
    );
  }
}