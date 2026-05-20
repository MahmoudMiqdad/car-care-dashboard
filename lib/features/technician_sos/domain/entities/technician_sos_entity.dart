class TechnicianSosEntity {
  final int? id;
  final double? lat;
  final double? lng;

  final String? description;

  final String? status;
  final String? statusText;
  final String? priority;

  // Vehicle
  final int? vehicleId;
  final String? vehicleBrand;
  final String? vehicleModel;
  final String? vehicleYear;
  final String? plateNumber;
  final int? currentKm;
  final String? vehicleImage;
  final String? vehicleImagePath;
  final String? vehicleStatus;
  final bool? needsMaintenance;

  // Owner
  final int? ownerId;
  final String? ownerName;

  // Technician
  final int? technicianId;
  final String? technicianName;
  final String? technicianPhone;

  final bool? canCancel;

  final String? createdAt;
  final String? createdAgo;

  TechnicianSosEntity({
    this.id,
    this.lat,
    this.lng,
    this.description,
    this.status,
    this.statusText,
    this.priority,

    this.vehicleId,
    this.vehicleBrand,
    this.vehicleModel,
    this.vehicleYear,
    this.plateNumber,
    this.currentKm,
    this.vehicleImage,
    this.vehicleImagePath,
    this.vehicleStatus,
    this.needsMaintenance,

    this.ownerId,
    this.ownerName,

    this.technicianId,
    this.technicianName,
    this.technicianPhone,

    this.canCancel,
    this.createdAt,
    this.createdAgo,
  });
}