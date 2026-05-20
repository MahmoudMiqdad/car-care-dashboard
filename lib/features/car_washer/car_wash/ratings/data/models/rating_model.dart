import 'package:car_care/features/car_washer/car_wash/ratings/domain/entities/ratings_entity.dart';

class RatingModel extends RatingEntity {
  const RatingModel({
    required super.id,
    required super.rating,
    required super.ratingStars,
    required super.review,
    required super.userId,
    required super.userName,
    required super.createdAt,
    required super.createdAgo,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>? ?? {};

    return RatingModel(
      id: _toInt(json['id']),
      rating: _toInt(json['rating']),
      ratingStars: (json['rating_stars'] ?? '').toString(),
      review: (json['review'] ?? '').toString(),
      userId: _toInt(user['id']),
      userName: (user['name'] ?? '').toString(),
      createdAt: (json['created_at'] ?? '').toString(),
      createdAgo: (json['created_ago'] ?? '').toString(),
    );
  }

  static int _toInt(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v) ?? 0;
    return 0;
  }
}