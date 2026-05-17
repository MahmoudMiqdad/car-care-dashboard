import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_care/features/car_washer/car_wash/bookings/domain/entities/bookings_entity.dart';
import 'package:car_care/features/car_washer/washers/washers_bookings/domain/repositories/i_bookings_repository.dart';
import 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit(this._repository) : super(BookingsInitial());

  final IBookingsRepository _repository;

  String? _currentStatus; 
  List<BookingsEntity> _currentItems = [];

  Future<void> fetchBookings({String? status}) async {
    _currentStatus = status;

    emit(BookingsLoading());

    final result = await _repository.getBookings(status: _currentStatus);

    result.fold((failure) => emit(BookingsError(failure.message)), (items) {
      _currentItems = items;
      emit(BookingsLoaded(items, status: _currentStatus ?? 'all'));
    });
  }

  Future<void> acceptBooking(int bookingId) async {
    emit(BookingActionLoading(bookingId));

    final result = await _repository.acceptBooking(bookingId);

    result.fold(
      (failure) => emit(
        BookingActionError(
          failure.message,
          currentItems: _currentItems,
          currentStatus: _currentStatus ?? 'all',
        ),
      ),
      (res) async {
        final msg = (res['message'] ?? 'تم قبول الحجز بنجاح').toString();
        emit(BookingActionSuccessMessage(msg));
        await fetchBookings(status: _currentStatus); // null => all
      },
    );
  }

  Future<void> rejectBooking(int bookingId, String reason) async {
    emit(BookingActionLoading(bookingId));

    final result = await _repository.rejectBooking(bookingId, reason);

    result.fold(
      (failure) => emit(
        BookingActionError(
          failure.message,
          currentItems: _currentItems,
          currentStatus: _currentStatus ?? 'all',
        ),
      ),
      (res) async {
        final msg = (res['message'] ?? 'تم رفض الحجز').toString();
        emit(BookingActionSuccessMessage(msg));
        await fetchBookings(status: _currentStatus);
      },
    );
  }

  Future<void> startExecution(int bookingId) async {
    emit(BookingActionLoading(bookingId));

    final result = await _repository.updateBookingStatus(bookingId, 'in_progress');

    result.fold(
      (failure) => emit(
        BookingActionError(
          failure.message,
          currentItems: _currentItems,
          currentStatus: _currentStatus ?? 'all',
        ),
      ),
      (res) async {
        final msg = (res['message'] ?? 'تم بدء التنفيذ بنجاح').toString();
        emit(BookingActionSuccessMessage(msg));
        await fetchBookings(status: _currentStatus);
      },
    );
  }

  Future<void> completeBooking(int bookingId) async {
    emit(BookingActionLoading(bookingId));

    final result = await _repository.updateBookingStatus(bookingId, 'completed');

    result.fold(
      (failure) => emit(
        BookingActionError(
          failure.message,
          currentItems: _currentItems,
          currentStatus: _currentStatus ?? 'all',
        ),
      ),
      (res) async {
        final msg = (res['message'] ?? 'تم إتمام الحجز بنجاح').toString();
        emit(BookingActionSuccessMessage(msg));
        await fetchBookings(status: _currentStatus);
      },
    );
  }
}
