import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  const RatingEntity({
    required this.id,
    required this.rating,
    required this.ratingStars,
    required this.review,
    required this.userId,
    required this.userName,
    required this.createdAt,
    required this.createdAgo,
  });

  final int id;
  final int rating;
  final String ratingStars;
  final String review;
  final int userId;
  final String userName;
  final String createdAt;
  final String createdAgo;

  @override
  List<Object?> get props => [id, rating, review];
}