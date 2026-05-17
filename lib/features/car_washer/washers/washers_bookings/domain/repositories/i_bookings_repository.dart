import 'package:car_care/features/car_washer/car_wash/bookings/domain/entities/bookings_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';

abstract class IBookingsRepository {
  Future<Either<Failure, List<BookingsEntity>>> getBookings({String? status});
  Future<Either<Failure, Map<String, dynamic>>> acceptBooking(int bookingId);
  Future<Either<Failure, Map<String, dynamic>>> rejectBooking(
    int bookingId,
    String reason,
  );
  Future<Either<Failure, Map<String, dynamic>>> updateBookingStatus(
    int bookingId,
    String status,
  );
}
