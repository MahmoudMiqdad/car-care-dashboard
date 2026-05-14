import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/car_washer/bookings/data/model/booking_model.dart';
import 'package:dio/dio.dart';

class CustomerBookingsRemoteDataSource {
  const CustomerBookingsRemoteDataSource(this._apiService);
  final ApiService _apiService;

  Future<List<BookingModel>> getBookings({String? status}) async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.customerCarwashBookings,
      queryParameters: {
        if (status != null && status.isNotEmpty) 'status': status,
      },
    );

    return BookingModel.listFromResponse(response);
  }

  Future<Map<String, dynamic>> cancelBooking(int bookingId, String reason) async {
    final res = await _apiService.post(
      endPoint: ApiEndpoints.customerCancelBooking(bookingId),
      data: FormData.fromMap({'cancellation_reason': reason}),
    );
    return res;
  }
}
