import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/car_washer/car_wash/bookings/domain/entities/bookings_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ICustomerBookingsRepository {
  Future<Either<Failure, List<BookingsEntity>>> getBookings({String? status});
  Future<Either<Failure, Map<String, dynamic>>> cancelBooking(int bookingId, String reason);
}