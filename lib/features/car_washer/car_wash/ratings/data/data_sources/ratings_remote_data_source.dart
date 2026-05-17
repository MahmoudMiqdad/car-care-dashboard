import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:dio/dio.dart';
import '../models/rating_model.dart';

class RatingsRemoteDataSource {
  const RatingsRemoteDataSource(this._apiService);
  final ApiService _apiService;

  Future<RatingModel> submitRating({
    required int bookingId,
    required int rating,
    required String review,
  }) async {
    final res = await _apiService.post(
      endPoint: ApiEndpoints.customerRateBooking(bookingId),
      data: FormData.fromMap({
        'rating': rating,
        'review': review,
      }),
    );
    final data = res['data'] as Map<String, dynamic>;
    return RatingModel.fromJson(data);
  }
}