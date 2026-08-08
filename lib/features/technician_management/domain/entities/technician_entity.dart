class TechnicianEntity {
  final int? id;
  final int? userId;
  final String? specialization;
  final int? experienceYears;
  final String? phone;
  final String? city;
  final String? hourlyRate;
  final bool? isAvailable;
  final String? status;
  final String? rejectionReason;
  final String? approvedAt;
  final String? rejectedAt;
  final String? suspendedAt;
  final List<String> certifications;
  final TechnicianUserEntity? user;
  final String? createdAt;
  final String? updatedAt;

  const TechnicianEntity({
    this.id,
    this.userId,
    this.specialization,
    this.experienceYears,
    this.phone,
    this.city,
    this.hourlyRate,
    this.isAvailable,
    this.status,
    this.rejectionReason,
    this.approvedAt,
    this.rejectedAt,
    this.suspendedAt,
    this.certifications = const [],
    this.user,
    this.createdAt,
    this.updatedAt,
  });
}

class TechnicianUserEntity {
  final int? id;
  final String? name;
  final String? email;

  const TechnicianUserEntity({this.id, this.name, this.email});
}
