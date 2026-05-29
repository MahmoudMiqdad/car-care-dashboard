import 'package:car_care/features/maintenance/user_requests/domain/entities/quotation_entity.dart';
import 'package:car_care/features/maintenance/user_requests/domain/entities/request_image_entity.dart';
import 'package:car_care/features/maintenance/user_requests/domain/entities/user_entity.dart';
import 'package:car_care/features/maintenance/user_requests/domain/entities/vehicle_entity.dart';

class MaintenanceRequestEntity {
  final bool? success;
  final String? message;
  final List<DataEntity> data;

  MaintenanceRequestEntity({
    this.success,
    this.message,
    required this.data,
  });
}
class DataEntity {
  final int? id;
  final String? description;
  final String? priority;
  final String? priorityText;
  final String? status;
  final String? statusText;
  final VehicleEntity? vehicle;
  final List<RequestImageEntity> images;
  final List<QuotationRequestEntity> quotations;
  final DateTime? preferredDate;
  final DateTime? createdAt;
  final String? createdAgo;
  final bool? canCancel;

  DataEntity({
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
}