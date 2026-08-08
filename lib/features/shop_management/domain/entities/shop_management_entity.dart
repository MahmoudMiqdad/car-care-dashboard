class ShopEntity {
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
  final ShopOwnerEntity? owner;
  final List<String> businessTypes;
  final List<String> carBrands;
  final List<String> partCategories;
  final String? createdAt;

  const ShopEntity({
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
}

class ShopOwnerEntity {
  final int? id;
  final String? name;
  final String? email;

  const ShopOwnerEntity({this.id, this.name, this.email});
}