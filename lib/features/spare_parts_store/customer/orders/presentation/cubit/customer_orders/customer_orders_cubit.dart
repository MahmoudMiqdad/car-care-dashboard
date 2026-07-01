import 'package:car_care/features/spare_parts_store/customer/orders/domain/repositories/i_customer_orders_repository.dart';
import 'package:car_care/features/spare_parts_store/customer/orders/presentation/cubit/customer_orders/customer_orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerOrdersCubit extends Cubit<CustomerOrdersState> {
  CustomerOrdersCubit(this._repository) : super(CustomerOrdersInitial());

  final ICustomerOrdersRepository _repository;
  String? _currentStatus;

  Future<void> fetchOrders({String? status}) async {
    _currentStatus = status;
    emit(CustomerOrdersLoading());

    final result = await _repository.getOrders(status: status);

    result.fold(
      (failure) => emit(CustomerOrdersError(failure.message)),
      (orders) {
        if (orders.isEmpty) {
          emit(CustomerOrdersEmpty(status));
        } else {
          emit(CustomerOrdersLoaded(orders, activeStatus: status));
        }
      },
    );
  }

  Future<void> cancelOrder(int orderId, String reason) async {
    final current = state;
    if (current is! CustomerOrdersLoaded) return;

    emit(
      CustomerOrdersLoaded(
        current.orders,
        activeStatus: current.activeStatus,
        cancellingIds: {...current.cancellingIds, orderId},
      ),
    );

    final result = await _repository.cancelOrder(orderId, reason);

    result.fold(
      (failure) => emit(
        CustomerOrdersLoaded(
          current.orders,
          activeStatus: current.activeStatus,
          actionError: failure.message,
        ),
      ),
      (_) => fetchOrders(status: _currentStatus),
    );
  }

  void clearActionError() {
    final current = state;
    if (current is CustomerOrdersLoaded && current.actionError != null) {
      emit(
        CustomerOrdersLoaded(
          current.orders,
          activeStatus: current.activeStatus,
          cancellingIds: current.cancellingIds,
        ),
      );
    }
  }
}
