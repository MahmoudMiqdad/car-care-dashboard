// advertisement_model.dart
class AdvertisementModel {
  final bool? success;
  final String? message;
  final AdvertisementData? data;

  AdvertisementModel({this.success, this.message, this.data});

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) => AdvertisementModel(
        success: json['success'],
        message: json['message'],
        data: json['data'] != null ? AdvertisementData.fromJson(json['data']) : null,
      );
}

class AdvertisementListModel {
  final bool? success;
  final List<AdvertisementData> data;
  final AdvertisementMetaModel? meta;

  AdvertisementListModel({this.success, required this.data, this.meta});

  factory AdvertisementListModel.fromJson(Map<String, dynamic> json) => AdvertisementListModel(
        success: json['success'],
        data: json['data'] != null
            ? List.from(json['data']).map((e) => AdvertisementData.fromJson(e)).toList()
            : [],
        meta: json['meta'] != null ? AdvertisementMetaModel.fromJson(json['meta']) : null,
      );
}

class AdvertisementMetaModel {
  final int? total;
  final int? perPage;
  final int? currentPage;

  AdvertisementMetaModel({this.total, this.perPage, this.currentPage});

  factory AdvertisementMetaModel.fromJson(Map<String, dynamic> json) => AdvertisementMetaModel(
        total: json['total'],
        perPage: json['per_page'],
        currentPage: json['current_page'],
      );
}

class AdvertisementData {
  final int? id;
  final String? title;
  final String? imagePath;
  final String? imageUrl;
  final String? placement;
  final String? linkUrl;
  final String? startsAt;
  final String? endsAt;
  final bool? isActive;
  final int? sortOrder;
  final int? createdBy;
  final int? updatedBy;
  final String? createdAt;
  final String? updatedAt;

  AdvertisementData({
    this.id,
    this.title,
    this.imagePath,
    this.imageUrl,
    this.placement,
    this.linkUrl,
    this.startsAt,
    this.endsAt,
    this.isActive,
    this.sortOrder,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory AdvertisementData.fromJson(Map<String, dynamic> json) => AdvertisementData(
        id: json['id'],
        title: json['title'],
        imagePath: json['image_path'],
        imageUrl: json['image_url'],
        placement: json['placement'],
        linkUrl: json['link_url'],
        startsAt: json['starts_at'],
        endsAt: json['ends_at'],
        isActive: json['is_active'],
        sortOrder: json['sort_order'],
        createdBy: json['created_by'],
        updatedBy: json['updated_by'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );
}