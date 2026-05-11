import 'package:dartz/dartz.dart';
import 'package:car_care/core/errors/filuar.dart';
import '../entities/bookings_entity.dart';

abstract class IBookingsRepository {
  Future<Either<Failure, List<BookingsEntity>>> getBookings({String? status});
  Future<Either<Failure, Map<String, dynamic>>> acceptBooking(int bookingId);
  Future<Either<Failure, Map<String, dynamic>>> rejectBooking(
    int bookingId,
    String reason,
  );
}
