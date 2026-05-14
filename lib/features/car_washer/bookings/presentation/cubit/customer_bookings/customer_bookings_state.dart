import 'package:car_care/features/car_washer/bookings/domain/entities/bookings_entity.dart';

abstract class CustomerBookingsState {}

class CustomerBookingsInitial extends CustomerBookingsState {}

class CustomerBookingsLoading extends CustomerBookingsState {}

class CustomerBookingsLoaded extends CustomerBookingsState {
  CustomerBookingsLoaded(this.items, {this.status});

  final List<BookingsEntity> items;
  final String? status; 
}

class CustomerBookingsError extends CustomerBookingsState {
  CustomerBookingsError(this.message);
  final String message;
}

class CustomerBookingActionLoading extends CustomerBookingsState {
  CustomerBookingActionLoading(this.bookingId, {required this.currentItems, required this.currentStatus});
  final int bookingId;
  final List<BookingsEntity> currentItems;
  final String? currentStatus;
}

class CustomerBookingActionSuccess extends CustomerBookingsState {
  CustomerBookingActionSuccess(this.message, {required this.currentItems, required this.currentStatus});
  final String message;
  final List<BookingsEntity> currentItems;
  final String? currentStatus;
}

class CustomerBookingActionError extends CustomerBookingsState {
  CustomerBookingActionError(this.message, {required this.currentItems, required this.currentStatus});
  final String message;
  final List<BookingsEntity> currentItems;
  final String? currentStatus;
}
class CustomerBookingCancelSuccess extends CustomerBookingsState {
  CustomerBookingCancelSuccess(this.message);
  final String message;
}