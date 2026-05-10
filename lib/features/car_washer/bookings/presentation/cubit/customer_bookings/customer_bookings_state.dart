import 'package:car_care/features/car_washer/bookings/domain/entities/bookings_entity.dart';

abstract class CustomerBookingsState {}

class CustomerBookingsInitial extends CustomerBookingsState {}
class CustomerBookingsLoading extends CustomerBookingsState {}
class CustomerBookingsLoaded extends CustomerBookingsState {
  CustomerBookingsLoaded(this.items, {required this.status});
  final List<BookingsEntity> items;
  final String status;
}
class CustomerBookingsError extends CustomerBookingsState {
  CustomerBookingsError(this.message);
  final String message;
}