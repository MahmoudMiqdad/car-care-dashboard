import 'package:car_care/core/errors/excptions.dart';
import 'package:car_care/core/errors/filuar.dart';
import 'package:car_care/features/car_washer/bookings/data/data_sources/bookings_remote_data_source.dart';
import 'package:car_care/features/car_washer/bookings/domain/entities/bookings_entity.dart';
import 'package:car_care/features/car_washer/bookings/domain/repositories/i_bookings_repository.dart';
import 'package:dartz/dartz.dart';

class BookingsRepositoryImpl implements IBookingsRepository {
  const BookingsRepositoryImpl(this._remote);
  final BookingsRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<BookingsEntity>>> getBookings({String? status}) async {
    try {
      final items = await _remote.getBookings(status: status);
      return Right(items);
    } on ServerExpcptions catch (e) {
      return Left(e.error);
    } catch (_) {
      return const Left(Failure(message: 'حدث خطأ أثناء جلب الحجوزات'));
    }
  }

 @override
Future<Either<Failure, Map<String, dynamic>>> acceptBooking(int bookingId) async {
  try {
    final res = await _remote.acceptBooking(bookingId);
    return Right(res);
  } on ServerExpcptions catch (e) {
    return Left(e.error);
  } catch (_) {
    return const Left(Failure(message: 'حدث خطأ أثناء قبول الحجز'));
  }
}

@override
Future<Either<Failure, Map<String, dynamic>>> rejectBooking(int bookingId, String reason) async {
  try {
    final res = await _remote.rejectBooking(bookingId, reason);
    return Right(res);
  } on ServerExpcptions catch (e) {
    return Left(e.error);
  } catch (_) {
    return const Left(Failure(message: 'حدث خطأ أثناء رفض الحجز'));
  }
}
}