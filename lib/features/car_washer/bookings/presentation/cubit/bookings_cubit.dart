import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_care/features/car_washer/bookings/domain/repositories/i_bookings_repository.dart';
import 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit(this._repository) : super(BookingsInitial());

  final IBookingsRepository _repository;
  String _currentStatus = 'completed';

  Future<void> fetchBookings({String? status}) async {
    _currentStatus = status ?? _currentStatus;
    emit(BookingsLoading());

    final result = await _repository.getBookings(status: _currentStatus);

    result.fold(
      (failure) => emit(BookingsError(failure.message)),
      (items) => emit(BookingsLoaded(items, status: _currentStatus)),
    );
  }
}