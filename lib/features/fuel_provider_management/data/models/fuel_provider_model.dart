class FuelProviderModel {
  final bool? success;
  final String? message;
  final FuelProviderData? data;

  FuelProviderModel({this.success, this.message, this.data});

  factory FuelProviderModel.fromJson(Map<String, dynamic> json) => FuelProviderModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? FuelProviderData.fromJson(json['data']) : null,
      );
}

class FuelProviderListModel {
  final bool? success;
  final List<FuelProviderData> data;
  final FuelProviderMetaModel? meta;

  FuelProviderListModel({this.success, required this.data, this.meta});

  factory FuelProviderListModel.fromJson(Map<String, dynamic> json) => FuelProviderListModel(
        success: json['success'],
        data: json['data'] != null
            ? List.from(json['data']).map((e) => FuelProviderData.fromJson(e)).toList()
            : [],
        meta: json['meta'] != null ? FuelProviderMetaModel.fromJson(json['meta']) : null,
      );
}

class FuelProviderMetaModel {
  final int? total;
  final int? perPage;
  final int? currentPage;

  FuelProviderMetaModel({this.total, this.perPage, this.currentPage});

  factory FuelProviderMetaModel.fromJson(Map<String, dynamic> json) => FuelProviderMetaModel(
        total: json['total'],
        perPage: json['per_page'],
        currentPage: json['current_page'],
      );
}

class FuelProviderData {
  final int? id;
  final String? companyName;
  final String? phone;
  final String? city;
  final String? address;
  final double? latitude;
  final double? longitude;
  final List<String> fuelTypes;
  final Map<String, dynamic> prices;
  final bool? isAvailable;
  final bool? isVerified;
  final String? status;
  final String? rejectionReason;
  final String? approvedAt;
  final String? rejectedAt;
  final String? suspendedAt;
  final FuelProviderUserData? user;
  final String? createdAt;

  FuelProviderData({
    this.id,
    this.companyName,
    this.phone,
    this.city,
    this.address,
    this.latitude,
    this.longitude,
    this.fuelTypes = const [],
    this.prices = const {},
    this.isAvailable,
    this.isVerified,
    this.status,
    this.rejectionReason,
    this.approvedAt,
    this.rejectedAt,
    this.suspendedAt,
    this.user,
    this.createdAt,
  });

  factory FuelProviderData.fromJson(Map<String, dynamic> json) => FuelProviderData(
        id: json['id'],
        companyName: json['company_name'],
        phone: json['phone'],
        city: json['city'],
        address: json['address'],
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        fuelTypes: json['fuel_types'] != null ? List<String>.from(json['fuel_types']) : [],
        prices: json['prices'] != null ? Map<String, dynamic>.from(json['prices']) : {},
        isAvailable: json['is_available'],
        isVerified: json['is_verified'],
        status: json['status'],
        rejectionReason: json['rejection_reason'],
        approvedAt: json['approved_at'],
        rejectedAt: json['rejected_at'],
        suspendedAt: json['suspended_at'],
        user: json['user'] != null ? FuelProviderUserData.fromJson(json['user']) : null,
        createdAt: json['created_at'],
      );
}

class FuelProviderUserData {
  final int? id;
  final String? name;
  final String? email;

  FuelProviderUserData({this.id, this.name, this.email});

  factory FuelProviderUserData.fromJson(Map<String, dynamic> json) => FuelProviderUserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
      );
}