import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/car_washer/washers/washers_ratings/data/models/car_washer_rating_model.dart';

class CarWasherRatingsRemoteDataSource {
  const CarWasherRatingsRemoteDataSource(this._apiService);
  final ApiService _apiService;

  Future<List<CarWasherRatingModel>> getRatings(int carWasherId) async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.customerCarWasherRatings(carWasherId),
    );

    final rawList = response['data'];
    if (rawList is! List) return [];
    return rawList
        .whereType<Map<String, dynamic>>()
        .map(CarWasherRatingModel.fromJson)
        .toList();
  }
}
