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