import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_care/features/car_washer/bookings/domain/repositories/i_customer_bookings_repository.dart';
import 'customer_bookings_state.dart';

class CustomerBookingsCubit extends Cubit<CustomerBookingsState> {
  CustomerBookingsCubit(this._repo) : super(CustomerBookingsInitial());

  final ICustomerBookingsRepository _repo;

  String _currentStatus = 'completed';

  Future<void> fetchBookings({String? status}) async {
    _currentStatus = status ?? _currentStatus;
    emit(CustomerBookingsLoading());

    final result = await _repo.getBookings(status: _currentStatus);

    result.fold(
      (f) => emit(CustomerBookingsError(f.message)),
      (items) => emit(CustomerBookingsLoaded(items, status: _currentStatus)),
    );
  }
}