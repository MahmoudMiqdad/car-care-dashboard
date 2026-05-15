import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/car_washer/ratings/domain/entities/ratings_entity.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/i_ratings_repository.dart';
import '../data_sources/ratings_remote_data_source.dart';

class RatingsRepositoryImpl implements IRatingsRepository {
  const RatingsRepositoryImpl(this._remote);
  final RatingsRemoteDataSource _remote;

  @override
  Future<Either<Failure, RatingEntity>> submitRating({
    required int bookingId,
    required int rating,
    required String review,
  }) async {
    try {
      final result = await _remote.submitRating(
        bookingId: bookingId,
        rating: rating,
        review: review,
      );
      return Right(result);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء إرسال التقييم'));
    }
  }
}