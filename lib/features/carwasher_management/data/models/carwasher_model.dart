class CarwasherModel {
  final bool? success;
  final String? message;
  final CarwasherData? data;

  CarwasherModel({this.success, this.message, this.data});

  factory CarwasherModel.fromJson(Map<String, dynamic> json) => CarwasherModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? CarwasherData.fromJson(json['data']) : null,
      );
}

class CarwasherListModel {
  final bool? success;
  final List<CarwasherData> data;
  final CarwasherMetaModel? meta;

  CarwasherListModel({this.success, required this.data, this.meta});

  factory CarwasherListModel.fromJson(Map<String, dynamic> json) => CarwasherListModel(
        success: json['success'],
        data: json['data'] != null
            ? List.from(json['data']).map((e) => CarwasherData.fromJson(e)).toList()
            : [],
        meta: json['meta'] != null ? CarwasherMetaModel.fromJson(json['meta']) : null,
      );
}

class CarwasherMetaModel {
  final int? total;
  final int? perPage;
  final int? currentPage;

  CarwasherMetaModel({this.total, this.perPage, this.currentPage});

  factory CarwasherMetaModel.fromJson(Map<String, dynamic> json) => CarwasherMetaModel(
        total: json['total'],
        perPage: json['per_page'],
        currentPage: json['current_page'],
      );
}

class CarwasherData {
  final int? id;
  final String? shopName;
  final String? phone;
  final String? city;
  final String? address;
  final String? logo;
  final List<String> services;
  final Map<String, dynamic> servicePrices;
  final Map<String, dynamic> workingHours;
  final String? description;
  final bool? isAvailable;
  final bool? isVerified;
  final String? status;
  final String? rejectionReason;
  final String? approvedAt;
  final String? rejectedAt;
  final String? suspendedAt;
  final num? averageRating;
  final int? ratingsCount;
  final String? ratingStars;
  final CarwasherUserData? user;
  final String? createdAt;

  CarwasherData({
    this.id,
    this.shopName,
    this.phone,
    this.city,
    this.address,
    this.logo,
    this.services = const [],
    this.servicePrices = const {},
    this.workingHours = const {},
    this.description,
    this.isAvailable,
    this.isVerified,
    this.status,
    this.rejectionReason,
    this.approvedAt,
    this.rejectedAt,
    this.suspendedAt,
    this.averageRating,
    this.ratingsCount,
    this.ratingStars,
    this.user,
    this.createdAt,
  });

  factory CarwasherData.fromJson(Map<String, dynamic> json) => CarwasherData(
        id: json['id'],
        shopName: json['shop_name'],
        phone: json['phone'],
        city: json['city'],
        address: json['address'],
        logo: json['logo'],
        services: json['services'] != null ? List<String>.from(json['services']) : [],
        servicePrices: json['service_prices'] != null
            ? Map<String, dynamic>.from(json['service_prices'])
            : {},
        workingHours: json['working_hours'] != null
            ? Map<String, dynamic>.from(json['working_hours'])
            : {},
        description: json['description'],
        isAvailable: json['is_available'],
        isVerified: json['is_verified'],
        status: json['status'],
        rejectionReason: json['rejection_reason'],
        approvedAt: json['approved_at'],
        rejectedAt: json['rejected_at'],
        suspendedAt: json['suspended_at'],
        averageRating: json['average_rating'],
        ratingsCount: json['ratings_count'],
        ratingStars: json['rating_stars'],
        user: json['user'] != null ? CarwasherUserData.fromJson(json['user']) : null,
        createdAt: json['created_at'],
      );
}

class CarwasherUserData {
  final int? id;
  final String? name;
  final String? email;

  CarwasherUserData({this.id, this.name, this.email});

  factory CarwasherUserData.fromJson(Map<String, dynamic> json) => CarwasherUserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
      );
}