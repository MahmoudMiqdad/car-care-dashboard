class ShopModel {
  final bool? success;
  final String? message;
  final ShopData? data;

  ShopModel({this.success, this.message, this.data});

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? ShopData.fromJson(json['data']) : null,
      );
}

class ShopListModel {
  final bool? success;
  final List<ShopData> data;
  final ShopMetaModel? meta;

  ShopListModel({this.success, required this.data, this.meta});

  factory ShopListModel.fromJson(Map<String, dynamic> json) => ShopListModel(
        success: json['success'],
        data: json['data'] != null
            ? List.from(json['data']).map((e) => ShopData.fromJson(e)).toList()
            : [],
        meta: json['meta'] != null ? ShopMetaModel.fromJson(json['meta']) : null,
      );
}

class ShopMetaModel {
  final int? total;
  final int? perPage;
  final int? currentPage;

  ShopMetaModel({this.total, this.perPage, this.currentPage});

  factory ShopMetaModel.fromJson(Map<String, dynamic> json) => ShopMetaModel(
        total: json['total'],
        perPage: json['per_page'],
        currentPage: json['current_page'],
      );
}

class ShopData {
  final int? id;
  final String? name;
  final String? phone;
  final String? city;
  final bool? isActive;
  final String? status;
  final String? rejectionReason;
  final String? approvedAt;
  final String? rejectedAt;
  final String? suspendedAt;
  final ShopOwnerData? owner;
  final List<String> businessTypes;
  final List<String> carBrands;
  final List<String> partCategories;
  final String? createdAt;

  ShopData({
    this.id,
    this.name,
    this.phone,
    this.city,
    this.isActive,
    this.status,
    this.rejectionReason,
    this.approvedAt,
    this.rejectedAt,
    this.suspendedAt,
    this.owner,
    this.businessTypes = const [],
    this.carBrands = const [],
    this.partCategories = const [],
    this.createdAt,
  });

  factory ShopData.fromJson(Map<String, dynamic> json) => ShopData(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        city: json['city'],
        isActive: json['is_active'],
        status: json['status'],
        rejectionReason: json['rejection_reason'],
        approvedAt: json['approved_at'],
        rejectedAt: json['rejected_at'],
        suspendedAt: json['suspended_at'],
        owner: json['owner'] != null ? ShopOwnerData.fromJson(json['owner']) : null,
        businessTypes: json['business_types'] != null ? List<String>.from(json['business_types']) : [],
        carBrands: json['car_brands'] != null ? List<String>.from(json['car_brands']) : [],
        partCategories: json['part_categories'] != null ? List<String>.from(json['part_categories']) : [],
        createdAt: json['created_at'],
      );
}

class ShopOwnerData {
  final int? id;
  final String? name;
  final String? email;

  ShopOwnerData({this.id, this.name, this.email});

  factory ShopOwnerData.fromJson(Map<String, dynamic> json) => ShopOwnerData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
      );
}