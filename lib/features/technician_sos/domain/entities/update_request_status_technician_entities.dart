class UpdateRequestStatusTechnicianEntity {
  final int? id;
  final double? lat;
  final double? lng;

  final String? description;

  final String? status;
  final String? statusText;
  final String? priority;

  final bool? canCancel;

  final String? createdAt;
  final String? createdAgo;

  UpdateRequestStatusTechnicianEntity({
    this.id,
    this.lat,
    this.lng,
    this.description,
    this.status,
    this.statusText,
    this.priority,
    this.canCancel,
    this.createdAt,
    this.createdAgo,
  });
}