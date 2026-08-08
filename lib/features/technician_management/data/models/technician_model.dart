class TechnicianModel {
  final bool? success;
  final String? message;
  final TechnicianData? data;

  TechnicianModel({this.success, this.message, this.data});

  factory TechnicianModel.fromJson(Map<String, dynamic> json) => TechnicianModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? TechnicianData.fromJson(json['data']) : null,
      );
}

class TechnicianListModel {
  final bool? success;
  final List<TechnicianData> data;
  final TechnicianMetaModel? meta;

  TechnicianListModel({this.success, required this.data, this.meta});

  factory TechnicianListModel.fromJson(Map<String, dynamic> json) => TechnicianListModel(
        success: json['success'],
        data: json['data'] != null
            ? List.from(json['data']).map((e) => TechnicianData.fromJson(e)).toList()
            : [],
        meta: json['meta'] != null ? TechnicianMetaModel.fromJson(json['meta']) : null,
      );
}

class TechnicianMetaModel {
  final int? total;
  final int? perPage;
  final int? currentPage;

  TechnicianMetaModel({this.total, this.perPage, this.currentPage});

  factory TechnicianMetaModel.fromJson(Map<String, dynamic> json) => TechnicianMetaModel(
        total: json['total'],
        perPage: json['per_page'],
        currentPage: json['current_page'],
      );
}

class TechnicianData {
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
  final List<String> certificationsRaw;
  final TechnicianUserData? user;
  final String? createdAt;
  final String? updatedAt;

  TechnicianData({
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
    this.certificationsRaw = const [],
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  factory TechnicianData.fromJson(Map<String, dynamic> json) => TechnicianData(
        id: json['id'],
        userId: json['user_id'],
        specialization: json['specialization'],
        experienceYears: json['experience_years'],
        phone: json['phone'],
        city: json['city'],
        hourlyRate: json['hourly_rate']?.toString(),
        isAvailable: json['is_available'],
        status: json['status'],
        rejectionReason: json['rejection_reason'],
        approvedAt: json['approved_at'],
        rejectedAt: json['rejected_at'],
        suspendedAt: json['suspended_at'],
        certifications: json['certifications'] != null
            ? List<String>.from(json['certifications'])
            : [],
        certificationsRaw: json['certifications_raw'] != null
            ? List<String>.from(json['certifications_raw'])
            : [],
        user: json['user'] != null ? TechnicianUserData.fromJson(json['user']) : null,
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
}

class TechnicianUserData {
  final int? id;
  final String? name;
  final String? email;

  TechnicianUserData({this.id, this.name, this.email});

  factory TechnicianUserData.fromJson(Map<String, dynamic> json) => TechnicianUserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
      );
}
