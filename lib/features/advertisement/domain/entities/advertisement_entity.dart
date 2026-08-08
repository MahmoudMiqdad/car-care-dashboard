// advertisement_entity.dart
class AdvertisementEntity {
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

  const AdvertisementEntity({
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
}