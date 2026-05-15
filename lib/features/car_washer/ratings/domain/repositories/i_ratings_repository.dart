import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/car_washer/ratings/domain/entities/ratings_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IRatingsRepository {
  Future<Either<Failure, RatingEntity>> submitRating({
    required int bookingId,
    required int rating,
    required String review,
  });
}