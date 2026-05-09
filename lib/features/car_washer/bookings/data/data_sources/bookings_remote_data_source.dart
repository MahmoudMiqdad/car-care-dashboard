import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/car_washer/bookings/data/model/booking_model.dart';

class BookingsRemoteDataSource {
  const BookingsRemoteDataSource(this._apiService);
  final ApiService _apiService;

  Future<List<BookingModel>> getBookings({String? status}) async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.washerMyBookings,
      queryParameters: {
        if (status != null) 'status': status,
      },
    );

    return BookingModel.listFromResponse(response);
  }
}