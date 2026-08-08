class CarwasherEntity {
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
  final CarwasherUserEntity? user;
  final String? createdAt;

  const CarwasherEntity({
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
}

class CarwasherUserEntity {
  final int? id;
  final String? name;
  final String? email;

  const CarwasherUserEntity({this.id, this.name, this.email});
}