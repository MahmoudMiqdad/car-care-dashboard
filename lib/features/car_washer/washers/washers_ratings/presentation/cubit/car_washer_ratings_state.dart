import 'package:car_care/features/car_washer/washers/washers_ratings/domain/entities/car_washer_rating_entity.dart';

abstract class CarWasherRatingsState {}

class CarWasherRatingsInitial extends CarWasherRatingsState {}

class CarWasherRatingsLoading extends CarWasherRatingsState {}

class CarWasherRatingsLoaded extends CarWasherRatingsState {
  CarWasherRatingsLoaded(this.ratings);
  final List<CarWasherRatingEntity> ratings;
}

class CarWasherRatingsError extends CarWasherRatingsState {
  CarWasherRatingsError(this.message);
  final String message;
}
