import 'package:car_care/core/network/api_endpoints.dart';
import 'package:car_care/core/network/api_service.dart';
import 'package:car_care/features/car_washer/bookings/data/model/booking_model.dart';
import 'package:dio/dio.dart';

class BookingsRemoteDataSource {
  const BookingsRemoteDataSource(this._apiService);
  final ApiService _apiService;

  Future<List<BookingModel>> getBookings({String? status}) async {
    final response = await _apiService.get(
      endPoint: ApiEndpoints.washerMyBookings,
      queryParameters: {
        if (status != null && status.isNotEmpty) 'status': status,
      },
    );

    return BookingModel.listFromResponse(response);
  }

  Future<Map<String, dynamic>> acceptBooking(int bookingId) async {
    final response = await _apiService.post(
      endPoint: ApiEndpoints.washerAcceptBooking(bookingId),
    );
    return response ;
  }

  Future<Map<String, dynamic>> rejectBooking(
    int bookingId,
    String reason,
  ) async {
    final response = await _apiService.post(
      endPoint: ApiEndpoints.washerRejectBooking(bookingId),
      data: FormData.fromMap({'rejection_reason': reason}),
    );
    return response;
  }
}
