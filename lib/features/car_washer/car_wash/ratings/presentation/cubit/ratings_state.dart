
import 'package:car_care/features/car_washer/car_wash/ratings/domain/entities/ratings_entity.dart';

abstract class RatingsState {}

class RatingsInitial extends RatingsState {}

class RatingsLoading extends RatingsState {}

class RatingsSuccess extends RatingsState {
  RatingsSuccess(this.rating, {required this.message});
  final RatingEntity rating;
  final String message;
}

class RatingsError extends RatingsState {
  RatingsError(this.message);
  final String message;
}