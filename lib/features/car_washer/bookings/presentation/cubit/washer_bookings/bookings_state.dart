import 'package:car_care/features/car_washer/bookings/domain/entities/bookings_entity.dart';

abstract class BookingsState {}

class BookingsInitial extends BookingsState {}

class BookingsLoading extends BookingsState {}

class BookingsLoaded extends BookingsState {
  final List<BookingsEntity> items;
  final String status;
  BookingsLoaded(this.items, {required this.status});
}

class BookingsError extends BookingsState {
  final String message;
  BookingsError(this.message);
}

// ── Action States ──
class BookingActionLoading extends BookingsState {
  final int bookingId;
  BookingActionLoading(this.bookingId);
}

class BookingActionSuccessMessage extends BookingsState {
  BookingActionSuccessMessage(this.message);
  final String message;
}

class BookingActionError extends BookingsState {
  final String message;
  final List<BookingsEntity> currentItems;
  final String currentStatus;
  BookingActionError(
    this.message, {
    required this.currentItems,
    required this.currentStatus,
  });
}
